using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace SPNR_Web.Models.DataBase
{
    public class SubEvent
    {
        [Key]
        [JsonIgnore]
        public Guid Id { get; set; }
        [Required]
        public string EventName { get; set; }
        [Required]
        public string EventDescription { get; set; }
        [Required]
        public DateTime Start { get; set; }
        [Required]
        public DateTime End { get; set; }
        public string ImgPath { get; set; }
        public string Place { get; set; }
        [Required]
        [JsonIgnore]
        public Guid EventId { get; set; }
        [ForeignKey("EventId")]
        [JsonIgnore]
        public Event Event { get; set; }
    }
}
