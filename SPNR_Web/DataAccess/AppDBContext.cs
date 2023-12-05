using Microsoft.EntityFrameworkCore;
using SPNR_Web.Models.DataBase;

namespace SPNR_Web.DataAccess
{
    public class AppDBContext : DbContext
    {
        public DbSet<Event> Events { get; set; }
        public DbSet<Header> Headers { get; set; }
        public DbSet<SubEvent> SubEvents { get; set; }
        public DbSet<TextBlock> Blocks { get; set; }
        public DbSet<User> Users { get; set; }
        public AppDBContext(DbContextOptions<AppDBContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>().HasIndex("Login");
            modelBuilder.HasPostgresExtension("uuid-ossp");
        }
    }
}
