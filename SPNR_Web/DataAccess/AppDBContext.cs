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
            modelBuilder.Entity<User>().HasData(
                new User ()
                {
                    Id = new Guid("f7c0b3fb-efed-414b-95b8-043efc9e24bc"),
                    Login = "root_user",
                    Password = "AQAAAAIAAYagAAAAEAdzXpS+NOjqjUhwet6RqBjMsF84qY1Bu5k6jIDOeE6IVG5wRN6VUwKB+5ubmxt3Vg=="
                }
                );
            modelBuilder.HasPostgresExtension("uuid-ossp");
            modelBuilder.Entity<User>().HasIndex("Login");
        }
    }
}
