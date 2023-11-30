namespace SPNR_Web.Models.DataBase
{
    public class Event
    {
        public Guid Id { get; set; }
        public string EventName { get; set; } = string.Empty;
        public string EventDescription { get; set; }
        DateTime DateTime { get; set; }
        public string ImgPath { get; set; } = string.Empty;

        //Relations
        public Header Header { get; set; }
        public List<TextBlock> Blocks { get; set; }
        public List<SubEvent> SubEvents { get; set; }
    }
}
