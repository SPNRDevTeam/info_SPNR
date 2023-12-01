using System.ComponentModel.DataAnnotations.Schema;

namespace SPNR_Web.Models.DataBase
{
    public class TextBlock
    {
        public Guid Id { get; set; }
        public string Header { get; set; }
        public string MainText {  get; set; }
        public string Footer {  get; set; }
        public string ImgPath {  get; set; }
        public Guid EventId { get; set; }
        [ForeignKey("EventId")]
        public Event Event { get; set; }
    }
}
