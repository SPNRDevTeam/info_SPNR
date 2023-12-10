using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace SPNR_Web.Models.DataBase
{
    public class Event
    {
        [Key]
        [JsonIgnore]
        public Guid Id { get; set; }
        public string EventName { get; set; }
        public string EventDescription { get; set; }
        public DateTime DateTime { get; set; }
        public string ImgPath { get; set; }
        [Required]
        public Header Header { get; set; }
        public List<TextBlock> Blocks { get; set; }
        public List<SubEvent> SubEvents { get; set; }
    }
}
