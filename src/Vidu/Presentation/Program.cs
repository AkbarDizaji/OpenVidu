using Application.Commands;
using Openvidu.Net.Aspnet.Core;
using Presentation;
using Presentation.Service;

var builder = WebApplication.CreateBuilder(args);


// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddApplicationServices();
//builder.Services.ConfigureOpenVidu();
//builder.Services.AddHostedService<StorageService>();



var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

//app.UseOpenVidu(new OpenViduWebhookOption()
//{
//    AcceptHeaders = new List<(string header, string value)>()
//    {
//        ("Authorization", "Basic T1BFTlZJRFVBUFA6TVlfU0VDUkVU"),
//    }
//});

app.UseAuthorization();

app.MapControllers();

app.Run();
