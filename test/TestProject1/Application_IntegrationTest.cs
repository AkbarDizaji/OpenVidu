using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Application.Commands;
using Application.Models;
using AutoMapper;
using Domain.Session;
using Infrastructure.GRPC;
using Infrastructure.Persistance;
using MediatR;
using Moq;
using Xunit;

namespace TestProject1
{
    public class Application_IntegrationTest
    {

        [Fact]
        public void CreateSessionCommand_update_success()
        {
            var userIds = new List<string>();
            userIds.Add("id1");
            userIds.Add("id2");
            var mapper = new Mock<IMapper>();
            var persist = new Mock<IPersistanceService>();
            var grpcService = new Mock<IGRPCService>();
            var session = new Session("id", false, "mediaMode", "recordMode", "codec", false);
            grpcService.Setup(g=>g.SendCreate())
                .Returns(session);
            mapper.Setup(m => m.Map<SessionDto>(session))
                .Returns(new SessionDto());
            var command = new CreateSessionCommand(userIds);
            var handler = new CreateSessionCommandHandler(mapper.Object,persist.Object,grpcService.Object);
            var result = handler.Handle(command, new CancellationToken()).GetAwaiter().GetResult();
            Assert.IsType<SessionDto>(result);
        }
        // other commands are in the same approach
    }
}
