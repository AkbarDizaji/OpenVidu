using Openvidu.Net.Aspnet.Contract;
using Openvidu.Net.Aspnet.Event;

namespace Presentation.Service;

public class StorageService : IHostedService
{
    private readonly IOpenViduService _openViduService;

    public StorageService(IOpenViduService openViduService)
    {
        _openViduService = openViduService;
    }

    private Task StoreEvent(OpenViduEvent @event)
    {
        //باید اینجا بیاد که نمیاد
        System.Diagnostics.Debug.WriteLine("Yessssssssssss");

        return Task.CompletedTask;
    }


    public void Init()
    {
        _openViduService.RegisterHandler(StoreEvent);
    }

    public Task StartAsync(CancellationToken cancellationToken)
    {
        Init();
        return Task.CompletedTask;
    }

    public Task StopAsync(CancellationToken cancellationToken)
    {
        return Task.CompletedTask;
    }
}