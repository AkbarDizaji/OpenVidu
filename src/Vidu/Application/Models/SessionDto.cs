using Application.Commons;
using Domain.Session;

namespace Application.Models;

public record SessionDto : IMapFrom<Session>
{
    public bool Recording;
    public string MediaMode;
    public string RecordingMode;
    public string ForcedVideoCodec;
    public bool allowTranscoding;
}
