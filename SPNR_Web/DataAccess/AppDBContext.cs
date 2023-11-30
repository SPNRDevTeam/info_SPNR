using Microsoft.EntityFrameworkCore;
using SPNR_Web.Models.DataBase;

namespace SPNR_Web.DataAccess
{
    public class AppDBContext : DbContext
    {
        DbSet<Event> Events { get; set; }
        DbSet<Header> Headers { get; set; }
        DbSet<SubEvent> SubEvents { get; set; }
        DbSet<TextBlock> Blocks { get; set; }
        public AppDBContext(DbContextOptions<AppDBContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasPostgresExtension("uuid-ossp");
        }
    }
}
