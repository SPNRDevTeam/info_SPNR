using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
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
        [Required]
        public string Name { get; set; }
        [Required]
        public string Description { get; set; }
        [Required]
        public string Text { get; set; }
        public DateTime DateTime { get; set; } = DateTime.Today;
        [ValidateNever]
        public string? ImgPath { get; set; }
    }
}
