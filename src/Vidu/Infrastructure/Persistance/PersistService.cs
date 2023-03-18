using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Domain.Session;

namespace Infrastructure.Persistance
{
    public class PersistService : IPersistanceService
    {
        private MongoClient mongoClient;
        private IMongoDatabase db;
        private IMongoCollection<Session> collection;

        public PersistService()
        {
            mongoClient = new MongoClient();
            db = mongoClient.GetDatabase("publisher");
            collection = db.GetCollection<Session>("sessions");
        }

        public async Task Insert(Session session, CancellationToken cancellationToken)
        {
            await collection.InsertOneAsync(session, cancellationToken);
        }

        public async Task Update(Session session, CancellationToken cancellationToken)
        {
            var filter = Builders<Session>.Filter.Eq(s => s.Id, session.Id);
            await collection.ReplaceOneAsync(filter, session);
        }

        public async Task<Session> GetSessionAsyncById(string Id, CancellationToken cancellationToken)
        {
            var filter = Builders<Session>.Filter.Eq(s => s.Id, Id);

            return await collection.Find(filter).FirstOrDefaultAsync();
        }

        public async Task<Session> FindByUserIdInSpecificSession(string id,string userId, CancellationToken cancellationToken)
        {
            var filter = Builders<Session>.Filter.Eq("UserIds", userId);
            filter &= (Builders<Session>.Filter.Eq("_id", id));
            var projection = Builders<Session>.Projection.Include("userIds");

            var item = await collection
                .Find(filter)
                //.Project(projection)
                .FirstOrDefaultAsync(cancellationToken);
            return item;
        }

    }
}
