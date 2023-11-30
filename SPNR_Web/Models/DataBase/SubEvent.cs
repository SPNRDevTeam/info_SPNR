namespace SPNR_Web.Models.DataBase
{
    public class SubEvent
    {
        public Guid Id { get; set; }
        public string EventName { get; set; } = string.Empty;
        public string EventDescription { get; set; }
        DateTime DateTime { get; set; }
        public string ImgPath { get; set; } = string.Empty;
        public string Place {  get; set; }
        public Guid EventId { get; set; }
        public Event Event { get; set; }
    }
}
