using Application.Models;
using Domain.Session;
using Infrastructure.GRPC;
using Infrastructure.Persistance;
using MongoDB.Driver;
using Presentation;
using Presentation.GRPC;

namespace Application.Commands;

public record CreateSessionCommand(List<string> UserIds) : IRequest<SessionDto>;

public class CreateSessionCommandHandler : IRequestHandler<CreateSessionCommand, SessionDto>
{
    private readonly IMapper _mapper;
    private readonly IPersistanceService _persistanceService;
    private readonly IGRPCService _grpcService;

    public CreateSessionCommandHandler(IMapper mapper, IPersistanceService persistanceService, IGRPCService grpcService)
    {
        _mapper = mapper;
        _grpcService = grpcService;
        _persistanceService = persistanceService;
    }
    public async Task<SessionDto> Handle(CreateSessionCommand request, CancellationToken cancellationToken)
    {
        var session =  _grpcService.SendCreate();

        foreach (var userId in request.UserIds)
        {
            session.AddUserId(userId);
        }

        await _persistanceService.Insert(session, cancellationToken);

        return _mapper.Map<SessionDto>(session);
    }
}