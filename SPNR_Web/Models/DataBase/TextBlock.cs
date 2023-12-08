using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace SPNR_Web.Models.DataBase
{
    public class TextBlock
    {
        public Guid Id { get; set; }
        public uint DisplayOrder { get; set; }
        [Required]
        public string MainText {  get; set; }
        public string ImgPath {  get; set; }
        [JsonIgnore]
        public Guid EventId { get; set; }
        [JsonIgnore]
        [ForeignKey("EventId")]
        public Event Event { get; set; }
    }
}
