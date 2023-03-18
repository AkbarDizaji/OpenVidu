using System;
using Domain.Session;
using Xunit;

namespace TestProject1;

public class DomainTest
{

    string id = "sampleId";
    bool recording = false;
    string mediaMode = "ROUTED";
    string recordingMode = "MANUAL";
    string forcedVideoCodec = "MEDIA_SERVER_PREFERRED";
    bool allowTranscoding = false;

    [Fact]
    public void constructor_should_create_session()
    {
        var session = new Session(id,recording,mediaMode,recordingMode,forcedVideoCodec,allowTranscoding);

        Assert.Equal(id,session.Id);
        Assert.Equal(recording, session.Recording);
        Assert.Equal(mediaMode, session.MediaMode);
        Assert.Equal(recordingMode, session.RecordingMode);
        Assert.Equal(forcedVideoCodec, session.ForcedVideoCodec);
        Assert.Equal(allowTranscoding, session.AllowTranscoding);
    }

    [Theory]
    [InlineData(null, "ROUTED", "MANUAL", "MEDIA_SERVER_PREFERRED")]
    [InlineData("sampleId", null, "MANUAL", "MEDIA_SERVER_PREFERRED")]
    [InlineData("sampleId", "ROUTED", null, "MEDIA_SERVER_PREFERRED")]
    [InlineData("sampleId", "ROUTED", "MANUAL", null)]
    public void constructor_throw_nullException_requiredfields_null
        (string id, string mediaMode, string recordingMode, string forcedVideoCodec)
    {
        Assert.Throws<ArgumentNullException>(() => new Session(id, false, mediaMode, recordingMode, forcedVideoCodec, false));
    }

    [Theory]
    [InlineData("", "ROUTED", "MANUAL", "MEDIA_SERVER_PREFERRED")]
    [InlineData("sampleId", "", "MANUAL", "MEDIA_SERVER_PREFERRED")]
    [InlineData("sampleId", "ROUTED", "", "MEDIA_SERVER_PREFERRED")]
    [InlineData("sampleId", "ROUTED", "MANUAL", "")]
    public void constructor_throw_argumentException_notEmptyFields_empty
        (string id, string mediaMode, string recordingMode, string forcedVideoCodec)
    {
        Assert.Throws<ArgumentException>(() => new Session(id, false, mediaMode, recordingMode, forcedVideoCodec, false));
    }

    [Fact]
    public void addConnection_return_session_with_connection()
    {
        var session = new Session(id, recording, mediaMode, recordingMode, forcedVideoCodec, allowTranscoding);
        session.AddConnection("connectionId", "connectionType", false);

        Assert.NotEmpty(session.Connections);
    }

    [Theory]
    [InlineData(null,"connectionType")]
    [InlineData("connectionId", null)]

    public void addConnection_throwNullException_connectionFields_null(string connectionId, string connectionType)
    {
        var session = new Session(id, recording, mediaMode, recordingMode, forcedVideoCodec, allowTranscoding);

        Assert.Throws<ArgumentNullException>(()=> session.AddConnection(connectionId, connectionType, false));
    }

    [Theory]
    [InlineData("", "connectionType")]
    [InlineData("connectionId", "")]

    public void addConnection_throwArgumentException_connectionFields_empty(string connectionId, string connectionType)
    {
        var session = new Session(id, recording, mediaMode, recordingMode, forcedVideoCodec, allowTranscoding);

        Assert.Throws<ArgumentException>(() => session.AddConnection(connectionId, connectionType, false));
    }
}