using SPNR_Web.Models.DataBase;

namespace SPNR_Web.DataAccess
{
    public interface IUnitOfWork
    {
        IRepository<Event> EventRepo { get; }
        IRepository<Header> HeaderRepo { get; }
        IRepository<Link> LinkRepo { get; }
        IRepository<SubEvent> SubEventRepo { get; }
        IRepository<TextBlock> BlockRepo { get; }
        IRepository<User> UserRepo { get; }
        void Save();
    }
}
