using Domain.Session;
using Grpc.Net.Client;
using Presentation.GRPC;

namespace Infrastructure.GRPC;

public class GRPCService : IGRPCService
{
    public Session SendCreate()
    {
        CreateSessionReply reply = new CreateSessionReply();
        var channel = GrpcChannel.ForAddress("https://localhost:7277");
        try
        {
            var client = new Greeter.GreeterClient(channel);
            var reply2 = client.SendSessionCreate(
                new CreateSessionRequest()
            );
            reply = reply2;
        }
        catch (Exception ex)
        {
            throw;
        }

        return new Session(reply.Id, reply.Recording, reply.MediaMode, reply.RecordingMode,
            reply.ForcedVideoCodec, reply.AllowTranscoding);
    }
}