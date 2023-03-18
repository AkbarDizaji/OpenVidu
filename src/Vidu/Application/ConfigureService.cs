using Infrastructure.GRPC;
using Infrastructure.Persistance;
using Microsoft.Extensions.Configuration;

namespace Microsoft.Extensions.DependencyInjection;

public static class ConfigureServices
{
    public static IServiceCollection AddApplicationServices(this IServiceCollection services)
    {
        services.AddAutoMapper(Assembly.GetExecutingAssembly());
        services.AddScoped<IPersistanceService, PersistService>();
        services.AddScoped<IGRPCService, GRPCService>();
        services.AddMediatR(cfg 
            => cfg.RegisterServicesFromAssemblies(
                Assembly.GetExecutingAssembly())
            );
        
        return services;
    }
}