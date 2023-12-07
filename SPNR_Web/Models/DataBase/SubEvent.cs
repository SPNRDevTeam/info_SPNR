using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SPNR_Web.Models.DataBase
{
    public class SubEvent
    {
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
        public Guid EventId { get; set; }
        [ForeignKey("EventId")]
        public Event Event { get; set; }
    }
}
