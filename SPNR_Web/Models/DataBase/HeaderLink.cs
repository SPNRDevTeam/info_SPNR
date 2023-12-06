using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SPNR_Web.Models.DataBase
{
    public class HeaderLink
    {
        public Guid Id { get; set; }
        public string Text { get; set; }
        public string Url { get; set; }
        [Required]
        public Guid HeaderId { get; set; }
        [ForeignKey("HeaderId")]
        public Header Header { get; set; }
    }
}
