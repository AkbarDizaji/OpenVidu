using Grpc.Core;
using Newtonsoft.Json.Linq;
using Presentation.GRPC;
using RestSharp;

namespace Presentation.GRPC.Services
{
    public class GreeterService : Greeter.GreeterBase
    {

        public override Task<CreateSessionReply> SendSessionCreate(CreateSessionRequest request, ServerCallContext context)
        {
            IConfiguration config = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json")
                .AddEnvironmentVariables().Build();

            var viduUrl  = config.GetValue<string>("ViduUrl");
            var BasicViduToken = config.GetValue<string>("Basic_Vidu_token");
            //var options = new RestClientOptions("")
            //{
            //    MaxTimeout = -1,
            //};
            var client = new RestClient();
            var sendRequest = new RestRequest(viduUrl, Method.Post);
            sendRequest.AddHeader("Authorization", BasicViduToken);
            //sendRequest.AddHeader("Cookie", "OVJSESSIONID=2D660E4A0E9725C1689149EA3A4C9DC1");
            RestResponse response =  client.ExecuteAsync(sendRequest).Result;
            var content = JObject.Parse(response.Content);

            return Task.FromResult(new CreateSessionReply
            {
                Id = content["id"].ToString(),
                Recording = (bool) content["recording"],
                MediaMode = content["mediaMode"].ToString(),
                RecordingMode = content["recordingMode"].ToString(),
                ForcedVideoCodec = content["forcedVideoCodec"].ToString(),
                AllowTranscoding = (bool) content["allowTranscoding"]
            });
        }
    }
}