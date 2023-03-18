using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Application.Models;
using Domain.Session;
using Infrastructure.Persistance;
using Newtonsoft.Json.Linq;
using Presentation.GRPC;
using RestSharp;

namespace Application.Commands;

public record CreateConnectionCommand(string Id,string UserId) : IRequest<string>;

public class CreateConnectionCommandHandler : IRequestHandler<CreateConnectionCommand, string>
{
    private readonly IPersistanceService _persistanceService;

    public CreateConnectionCommandHandler(IPersistanceService persistanceService)
    {
        _persistanceService = persistanceService;
    }
    public async Task<string> Handle(CreateConnectionCommand request, CancellationToken cancellationToken)
    {
        var session = await _persistanceService
            .FindByUserIdInSpecificSession(request.Id, request.UserId,cancellationToken);

        if (session == null)
        {
            throw new ArgumentNullException("The session does not exist or this userId isn't allowded participant");
        }

        //should be refactor: use interface here and move implementation to infrastructure
        var client = new RestClient();
        var restTequest = new RestRequest("http://localhost:4443/openvidu/api/sessions/"+session.Id+"/connection", Method.Post);
        restTequest.AddHeader("Authorization", "Basic T1BFTlZJRFVBUFA6TVlfU0VDUkVU");
        RestResponse response = await client.ExecuteAsync(restTequest);
        if (response.Content != null)
        {
            var content = JObject.Parse(response.Content);
            session.AddConnection(content["id"] is not null ? content["id"]!.ToString():"",
                content["type"] is not null ? content["type"]!.ToString():"", 
                (bool)(content["record"] ?? false));
            await _persistanceService.Update(session, cancellationToken);
            return content["token"].ToString().Remove(0, 5);
        }
        else
        {
            return "";
        }
    }
}