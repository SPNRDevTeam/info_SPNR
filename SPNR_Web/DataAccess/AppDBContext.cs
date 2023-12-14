using Microsoft.EntityFrameworkCore;
using SPNR_Web.Models.DataBase;

namespace SPNR_Web.DataAccess
{
    public class AppDBContext : DbContext
    {
        public DbSet<Event> Events { get; set; }
        public DbSet<MediaLink> MediaLinks { get; set; }
        public DbSet<News> News { get; set; }
        public DbSet<User> Users { get; set; }
        public AppDBContext(DbContextOptions<AppDBContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasPostgresExtension("uuid-ossp");
            modelBuilder.Entity<User>().HasIndex("Login");
        }
    }
}
