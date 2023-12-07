using SPNR_Web.Models.DataBase;

namespace SPNR_Web.Models.VMs
{
    public class HomeEventVM
    {
        public Event Event { get; set; }
        public Header Header { get; set; }
        public IEnumerable<HeaderLink> HeaderLinks { get; set; }
        public IEnumerable<TextBlock> Blocks { get; set; }
        public IEnumerable<SubEvent> SubEvents { get; set; }
    }
}
