using Dawn;

namespace Domain.Session;

public class Session
{

    public string Id { get; private set; }

    public bool Recording { get; private set; }

    public string MediaMode { get; private set; }

    public string RecordingMode { get; private set; }

    public string ForcedVideoCodec { get; private set; }

    public bool AllowTranscoding { get; private set; }

    public int Duration { get; private set; }

    public string Reason { get; private set; }

    public List<Connection> Connections { get; private set; }

    public List<string> UserIds { get; private set; } 


    /// <summary>
    ///     Default constructor used by mappers and ORMs to create instances.
    /// </summary>
    private Session()
    {
    }

    public Session(string id, bool recording, string mediaMode, string recordingMode, string forcedVideoCodec,
        bool allowTranscoding)
    {
        Guard.Argument(() => id).NotNull().NotEmpty();
        Guard.Argument(() => mediaMode).NotNull().NotEmpty();
        Guard.Argument(() => recordingMode).NotNull().NotEmpty();
        Guard.Argument(() => forcedVideoCodec).NotNull().NotEmpty();

        Id = id;
        Recording = recording;
        MediaMode = mediaMode;
        RecordingMode = recordingMode;
        ForcedVideoCodec = forcedVideoCodec;
        AllowTranscoding = allowTranscoding;
        Connections = new List<Connection>();
        UserIds = new List<string>();
    }

    public Session AddConnection(string connectionId, string connectionType, bool connectionRecord)
    {
        Guard.Argument(() => connectionId).NotNull().NotEmpty();
        Guard.Argument(() => connectionType).NotNull().NotEmpty();

        var connection = new Connection(connectionId, connectionType, connectionRecord);
        Connections.Add(connection);
        return this;
    }

    public Session RemoveConnection(Connection connection)
    {
        Connections.Remove(connection);
        return this;
    }

    public Session AddUserId(string userId)
    {
        UserIds.Add(userId);
        return this;
    }

    public Session AddClosedInfo(int duration, string reason)
    {
        Duration = duration;
        Reason = reason;
        return this;
    }

    public Session RemoveUserId(string userId)
    {
        UserIds.Remove(userId);
        return this;
    }
}