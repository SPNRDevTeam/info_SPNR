using System.ComponentModel.DataAnnotations;

namespace SPNR_Web.Models.DataBase
{
    public class User
    {
        [Key]
        public Guid Id { get; set; } = Guid.NewGuid();
        public string Login { get; set; }
        public string Password { get; set; }
    }
}
