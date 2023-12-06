using System.ComponentModel.DataAnnotations;

namespace SPNR_Web.Models.DataBase
{
    public class News
    {
        [Key]
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string ImgUrl { get; set; }
        public string Description { get; set; }
    }
}
