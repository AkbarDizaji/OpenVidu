using Domain.Session;
using Infrastructure.Persistance;
using Newtonsoft.Json.Linq;
using RestSharp;

namespace Application.Commands;

public record UpdateSessionCommand(string Id, int Duration, string Reason) : IRequest<Session>;

public class UpdateSessionCommandHandler : IRequestHandler<UpdateSessionCommand, Session>
{
    private readonly IPersistanceService _persistanceService;

    public UpdateSessionCommandHandler(IPersistanceService persistanceService)
    {
        _persistanceService = persistanceService;
    }
    public async Task<Session> Handle(UpdateSessionCommand request, CancellationToken cancellationToken)
    {
        var session = await _persistanceService
            .GetSessionAsyncById(request.Id, cancellationToken);

        if (session == null)
        {
            throw new Exception("The session does not exist or this userId isn't allowded participant");
        }

        var updatedSession = session.AddClosedInfo(request.Duration, request.Reason);

        await _persistanceService.Update(updatedSession, cancellationToken);
        return updatedSession;
    }
}