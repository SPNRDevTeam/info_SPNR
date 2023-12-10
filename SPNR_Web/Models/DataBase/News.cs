using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace SPNR_Web.Models.DataBase
{
    public class News
    {
        [Key]
        [JsonIgnore]
        public Guid Id { get; set; }
        public DateTime PublicationTime { get; set; }
        public string Name { get; set; }
        public string ImgPath { get; set; }
        public string Description { get; set; }
    }
}
