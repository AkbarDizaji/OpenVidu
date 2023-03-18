using Application.Models;
using Domain.Session;
using Infrastructure.Persistance;
using Newtonsoft.Json.Linq;
using Presentation.GRPC;
using RestSharp;

namespace Application.Commands;

public record CloseSessionCommand(string SessionId) : IRequest<Unit>;

public class CloseSessionCommandHandler : IRequestHandler<CloseSessionCommand, Unit>
{
    private readonly IPersistanceService _persistanceService;

    public CloseSessionCommandHandler(IPersistanceService persistanceService)
    {
        _persistanceService = persistanceService;
    }
    public async Task<Unit> Handle(CloseSessionCommand request, CancellationToken cancellationToken)
    {
        var session = await _persistanceService
            .GetSessionAsyncById(request.SessionId, cancellationToken);

        if (session == null)
        {
            throw new ArgumentNullException("The session with this id is not exist!");
        }

        var client = new RestClient();
        var httpRequest = new RestRequest("http://localhost:4443/openvidu/api/sessions/" + request.SessionId, Method.Delete);
        httpRequest.AddHeader("Authorization", "Basic T1BFTlZJRFVBUFA6TVlfU0VDUkVU");
        RestResponse response = await client.ExecuteAsync(httpRequest);
        
        return Unit.Value;
    }
}