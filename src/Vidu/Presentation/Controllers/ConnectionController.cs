using Application.Commands;

namespace Presentation.Controllers;

/// <summary>
///     Actions for managing connection.
/// </summary>
///
[Route("api/[controller]")]
[ApiController]
public class ConnectionController : Controller
{
    protected IMediator Mediator => HttpContext.RequestServices.GetRequiredService<IMediator>();
    

    /// <summary>
    ///     Create a new connection.
    /// </summary>
    /// <param name="request">The create connection request.</param>
    /// <param name="cancellationToken">Cancellation token of the request.</param>
    /// <returns>The newly created connection.</returns>
    /// <response code="400">The request payload is not valid.</response>
    [HttpPost]
    [ProducesResponseType(201)]
    [ProducesResponseType(400)]
    public async Task CreateConnection(
        [FromBody] CreateConnectionCommand request,
        CancellationToken cancellationToken
    ) => await Mediator.Send(request, cancellationToken); 
}