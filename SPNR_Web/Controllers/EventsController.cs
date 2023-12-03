using Microsoft.AspNetCore.Mvc;

namespace SPNR_Web.Controllers
{
    public class EventsController : Controller
    {
        public EventsController()
        {
        }

        public IActionResult Index(int? id)
        {
            if (id is null) { return View(); }
            return BadRequest();
        }

        public IActionResult Add()
        {
            return View();
        }
    }
}