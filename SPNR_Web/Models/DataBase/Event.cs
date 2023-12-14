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
        public string Name { get; set; }
        public string Description { get; set; }
        public string Text { get; set; }
        public DateTime DateTime { get; set; }
        public string ImgPath { get; set; }
    }
}
