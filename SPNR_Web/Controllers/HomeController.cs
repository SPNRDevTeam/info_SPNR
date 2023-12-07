using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using SPNR_Web.Models.DataBase;
using SPNR_Web.Utils;
using SPNR_Web.DataAccess;
using SPNR_Web.Models.VMs;

namespace SPNR_Web.Controllers
{
    public class HomeController : Controller
    {
        IUnitOfWork _unit;
        public HomeController(IUnitOfWork unit)
        {
            _unit = unit;
        }

        public IActionResult Index()
        {
            HomeIndexVM VM = new HomeIndexVM();
            VM.Events = _unit.EventRepo.ReadAll();
            VM.News = _unit.NewsRepo.ReadAll().OrderBy(n => n.PublicationTime);
            return View(VM);
        }
        public IActionResult Event(Guid id)
        {
            Event? @event = _unit.EventRepo.ReadFirst(u => u.Id == id);
            if (@event == null) return View(null);

            HomeEventVM VM = new HomeEventVM();
            VM.Event = @event;
            VM.Header = _unit.HeaderRepo.ReadFirst(h => h.EventId == id);
            VM.HeaderLinks = _unit.HeaderLinkRepo.ReadWhere(l => l.HeaderId == VM.Header.Id);
            VM.Blocks = _unit.BlockRepo.ReadWhere(b => b.EventId == id);
            VM.SubEvents = _unit.SubEventRepo.ReadWhere(s => s.EventId == id);
            return View(VM);
        }
        public IActionResult News()
        {
            IEnumerable<News> news = _unit.NewsRepo.ReadAll().OrderBy(n => n.PublicationTime);
            return View(news);
        }
        public IActionResult About() 
        {
            return View();
        }
        public IActionResult Media() 
        {
            IEnumerable<MediaLink> links = _unit.MediaLinkRepo.ReadAll().OrderBy(l => l.CreationTime);
            return View(links);
        }
    }
}