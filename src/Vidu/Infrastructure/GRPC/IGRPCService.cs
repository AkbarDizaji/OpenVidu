using Domain.Session;

namespace Infrastructure.GRPC;

public interface IGRPCService
{
    Session SendCreate();
}