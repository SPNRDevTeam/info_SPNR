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
            modelBuilder.Entity<User>().HasData(new User
            {
                Id = new("647cc151-245c-4364-b93b-34c8976aa019"),
                Login = "root_user",
                Password = "AQAAAAIAAYagAAAAEGc6P7EULkVfkO5MivnITxyl8gk3BeSTSFv9XqisrvUTPiS5T4RF6lzac71k7OvB6Q=="
            });
            modelBuilder.HasPostgresExtension("uuid-ossp");
            modelBuilder.Entity<User>().HasIndex("Login");
        }
    }
}
