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
            VM.News = _unit.NewsRepo.ReadAll();
            VM.MediaLinks = _unit.MediaLinkRepo.ReadAll();
            return View(VM);
        }
        public IActionResult Event(Guid id)
        {
            Event? @event = _unit.EventRepo.ReadFirst(u => u.Id == id);
            if (@event == null) return RedirectToAction("Index");

            HomeEventVM VM = new HomeEventVM();
            VM.Event = @event;
            return View(VM);
        }
        public IActionResult News()
        {
            IEnumerable<News> news = _unit.NewsRepo.ReadAll();
            return View(news);
        }
        public IActionResult About() 
        {
            return View();
        }
        public IActionResult Media() 
        {
            IEnumerable<MediaLink> links = _unit.MediaLinkRepo.ReadAll();
            return View(links);
        }
    }
}