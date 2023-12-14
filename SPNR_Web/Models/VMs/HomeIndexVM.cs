using SPNR_Web.Models.DataBase;

namespace SPNR_Web.Models.VMs
{
    public class HomeIndexVM
    {
        public IEnumerable<Event> Events { get; set; }
        public IEnumerable<News> News { get; set; }
    }
}
 