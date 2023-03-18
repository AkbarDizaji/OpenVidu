using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Application.Commons.Mappings;
using Application.Models;
using AutoMapper;
using Domain.Session;
using Xunit;

namespace TestProject1;

public class Application_UnitTest
{
    private readonly IConfigurationProvider _configuration;
    private readonly IMapper _mapper;

    public Application_UnitTest()
    {
        _configuration = new MapperConfiguration(config =>
            config.AddProfile<MappingProfile>());
        _mapper = _configuration.CreateMapper();
    }

    [Theory]
    [InlineData(typeof(Session), typeof(SessionDto))] 
    public void Map_From_Source_To_Destination_convert_correct(Type source, Type destination)
    {
        var sourceInstance = GetInstanceOf(source);

        var destinationInstance = _mapper.Map(sourceInstance, source, destination);
        Assert.IsType(destination, destinationInstance);
    }

    private object GetInstanceOf(Type type)
    {
        if (type.GetConstructor(Type.EmptyTypes) != null)
            return Activator.CreateInstance(type)!;
        return FormatterServices.GetUninitializedObject(type);
    }
}