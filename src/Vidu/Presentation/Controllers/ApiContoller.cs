using Openvidu.Net.Aspnet.Contract;
using Openvidu.Net.Aspnet.Event;

namespace Presentation.Controllers;

[ApiController]
[Route("[controller]")]
public class ApiController : ControllerBase
{
    private readonly ILogger<ApiController> _logger;
    private readonly IOpenViduService _openViduService;

    public ApiController(ILogger<ApiController> logger, IOpenViduService openViduService)
    {
        _logger = logger;
        _openViduService = openViduService;

        _openViduService.RegisterHandler(SaveEvent);
    }

    private Task SaveEvent(OpenViduEvent data)
    {
        // this method trigger when Openvidu server call Webhook endpoint
        // you can store Json message content anywhere

        _logger.LogInformation(data.Json);
        System.Diagnostics.Debug.WriteLine("Yessssssssssss");

        return Task.CompletedTask;
    }

}