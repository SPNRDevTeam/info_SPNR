using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace SPNR_Web.Models.DataBase
{
    public class HeaderLink
    {
        [Key]
        [JsonIgnore]
        public Guid Id { get; set; }
        public string Text { get; set; }
        public string Url { get; set; }
        public int DisplayOrder { get; set; }
        [Required]
        [JsonIgnore]
        public Guid HeaderId { get; set; }
        [ForeignKey("HeaderId")]
        [JsonIgnore]
        public Header Header { get; set; }
    }
}
