using Microsoft.EntityFrameworkCore;
using SPNR_Web.Models.DataBase;

namespace SPNR_Web.DataAccess
{
    public class AppDBContext : DbContext
    {
        public DbSet<Event> Events { get; set; }
        public DbSet<Header> Headers { get; set; }
        public DbSet<HeaderLink> HeaderLinks { get; set; }
        public DbSet<MediaLink> MediaLinks { get; set; }
        public DbSet<News> News { get; set; }
        public DbSet<SubEvent> SubEvents { get; set; }
        public DbSet<TextBlock> Blocks { get; set; }
        public DbSet<User> Users { get; set; }
        public AppDBContext(DbContextOptions<AppDBContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasPostgresExtension("uuid-ossp");
            modelBuilder.Entity<User>().HasIndex("Login");
            modelBuilder.Entity<TextBlock>().HasIndex("EventId", "DisplayOrder");
        }
    }
}
