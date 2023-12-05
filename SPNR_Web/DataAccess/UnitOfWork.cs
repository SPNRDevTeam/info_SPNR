

using SPNR_Web.Models.DataBase;

namespace SPNR_Web.DataAccess
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly AppDBContext _db;
        public IRepository<Event> EventRepo { get; private set; }
        public IRepository<Header> HeaderRepo { get; private set; }
        public IRepository<Link> LinkRepo { get; private set; }
        public IRepository<SubEvent> SubEventRepo { get; private set; }
        public IRepository<TextBlock> BlockRepo { get; private set; }
        public IRepository<User> UserRepo { get; private set; }
        public UnitOfWork(AppDBContext db)
        {
            _db = db;
            EventRepo = new Repository<Event>(db);
            HeaderRepo = new Repository<Header>(db);
            LinkRepo = new Repository<Link>(db);
            SubEventRepo = new Repository<SubEvent>(db);
            BlockRepo = new Repository<TextBlock>(db);
            UserRepo = new Repository<User>(db);
        }

        public void Save()
        {
            _db.SaveChanges();
        }
    }
}
