using Domain.Session;

namespace Infrastructure.Persistance;

public interface IPersistanceService
{
    Task<Session> GetSessionAsyncById(string Id, CancellationToken cancellationToken);

    Task<Session> FindByUserIdInSpecificSession(string id, string userId,CancellationToken cancellationToken);

    Task Insert(Session session, CancellationToken cancellationToken);

    Task Update(Session session, CancellationToken cancellationToken);
}