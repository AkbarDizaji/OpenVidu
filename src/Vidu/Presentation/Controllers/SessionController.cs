using System.Text;
using Application.Commands;
using Microsoft.AspNetCore.Authorization;
using Newtonsoft.Json.Linq;
using Openvidu.Net.Aspnet.Contract;
using Openvidu.Net.Aspnet.Event;

namespace Presentation.Controllers;

/// <summary>
///     Actions for managing sessions.
/// </summary>
///
[Route("[controller]")]
[AllowAnonymous]

[ApiController]
public class SessionController : Controller
{
    protected IMediator Mediator => HttpContext.RequestServices.GetRequiredService<IMediator>();
    

    /// <summary>
    ///     Create a new session.
    /// </summary>
    /// <param name="request">The create session request.</param>
    /// <param name="cancellationToken">Cancellation token of the request.</param>
    /// <returns>The newly created session.</returns>
    /// <response code="400">The request payload is not valid.</response>
    [HttpPost]
    [ProducesResponseType(201)]
    [ProducesResponseType(400)]
    public async Task CreateSession(
        [FromBody] CreateSessionCommand request,
        CancellationToken cancellationToken
    ) => await Mediator.Send(request, cancellationToken);

    /// <summary>
    ///     Close a new session.
    /// </summary>
    /// <param name="request">The close session request.</param>
    /// <param name="cancellationToken">Cancellation token of the request.</param>
    /// <response code="400">The request payload is not valid.</response>
    [HttpDelete("sessionId")]
    [ProducesResponseType(201)]
    [ProducesResponseType(400)]
    public async Task CloseSession(
        string sessionId,
        CancellationToken cancellationToken
    ) => await Mediator.Send(new CloseSessionCommand(sessionId), cancellationToken);

    [HttpPost]
    [Route("webhook")]
    public async Task ViduCallBack()
    {
        var a = 2;

        var req = HttpContext.Request;

        using StreamReader reader = new StreamReader(req.Body, Encoding.UTF8, true, 1024, true);

        var bodyStr = await reader.ReadToEndAsync();

        var content = JObject.Parse(bodyStr);

        if (content["event"].ToString() == "sessionDestroyed")
        {
            await Mediator.Send(new UpdateSessionCommand(content["sessionId"].ToString(), Int32.Parse(content["duration"].ToString()), content["reason"].ToString()), new CancellationToken());
        }

    }

}