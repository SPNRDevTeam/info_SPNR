using Microsoft.EntityFrameworkCore;
using SPNR_Web.Models.DataBase;

namespace SPNR_Web.DataAccess
{
    public interface IUnitOfWork
    {
        public IRepository<Event> EventRepo { get; }
        public IRepository<Header> HeaderRepo { get; }
        public IRepository<HeaderLink> HeaderLinkRepo { get; }
        public IRepository<MediaLink> MediaLinkRepo { get; }
        public IRepository<News> NewsRepo { get; }
        public IRepository<SubEvent> SubEventRepo { get; }
        public IRepository<TextBlock> BlockRepo { get; }
        public IRepository<User> UserRepo { get; }
        void Save();
    }
}
