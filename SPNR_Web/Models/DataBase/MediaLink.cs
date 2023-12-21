using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace SPNR_Web.Models.DataBase
{
    public class MediaLink
    {
        [Key]
        [JsonIgnore]
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Url { get; set; }
        public DateTime CreationTime { get; set; } = DateTime.Now;
    }
}
