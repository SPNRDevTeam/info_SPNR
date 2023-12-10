using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace SPNR_Web.Models.DataBase
{
    public class Header
    {
        [Key]
        [JsonIgnore]
        public Guid Id { get; set; }
        [Required]
        public string Text { get; set; }
        public string? ImgPath { get; set; }
        public List<HeaderLink> Links { get; set; }
        [Required]
        [JsonIgnore]
        public Guid EventId { get; set; }
        [ForeignKey("EventId")]
        [JsonIgnore]
        public Event Event { get; set; }
    }
}
