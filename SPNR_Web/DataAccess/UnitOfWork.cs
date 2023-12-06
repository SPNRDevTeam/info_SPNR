

using SPNR_Web.Models.DataBase;

namespace SPNR_Web.DataAccess
{
    public class UnitOfWork : IUnitOfWork
    {
        AppDBContext _db;
        public IRepository<Event> EventRepo { get; private set;  }
        public IRepository<Header> HeaderRepo { get; private set;  }
        public IRepository<HeaderLink> HeaderLinkRepo { get; private set;  }
        public IRepository<MediaLink> MediaLinkRepo { get; private set;  }
        public IRepository<News> NewsRepo { get; private set;  }
        public IRepository<SubEvent> SubEventRepo { get; private set;  }
        public IRepository<TextBlock> BlockRepo { get; private set;  }
        public IRepository<User> UserRepo { get; private set;  }
        public UnitOfWork(AppDBContext db)
        {
            _db = db;
            EventRepo = new Repository<Event>(db);
            HeaderRepo = new Repository<Header>(db);
            HeaderLinkRepo = new Repository<HeaderLink>(db);
            MediaLinkRepo = new Repository<MediaLink>(db);
            NewsRepo = new Repository<News>(db);
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
