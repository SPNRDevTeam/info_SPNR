using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SPNR_Web.Models.DataBase
{
    public class Header
    {
        public Guid Id { get; set; }
        [Required]
        public string Text { get; set; }
        public string ImgPath { get; set; }
        public List<Link> Links { get; set; }
        [Required]
        public Guid EventId { get; set; }
        [ForeignKey("EventId")]
        public Event Event { get; set; }
    }
}
