using Microsoft.AspNetCore.Mvc;
using SPNR_Web.DataAccess;
using SPNR_Web.Models.DataBase;
using SPNR_Web.Utils;

namespace SPNR_Web.Controllers
{
    public class ConstructorController : Controller
    {
        IUnitOfWork _unit;
        IFileHandler _fileHandler;
        public ConstructorController(IUnitOfWork unit, IFileHandler fileHandler) 
        {
            _unit = unit;
            _fileHandler = fileHandler;
        }
        public IActionResult Event(Guid? id)
        {
            if (id is null) return View(new Event());
            Event? @event = _unit.EventRepo.ReadFirst(e => e.Id == id);
            if (@event is null) return ToHome();
            return View(@event);
        }

        public IActionResult News()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Event(Event @event, IFormFile? file)
        {
            if (@event.Id == Guid.Empty)
            {
                @event.Id = Guid.NewGuid();
                if (file is not null) @event.ImgPath = _fileHandler.Save(file);
                _unit.EventRepo.Add(@event);
            }
            else
            {
                if (file is not null)
                {
                    _fileHandler.Delete(@event.ImgPath);
                    @event.ImgPath = _fileHandler.Save(file);
                }
                _unit.EventRepo.Update(@event);
            }
            _unit.Save();
            //toastr
            return ToHome();
        }

        [HttpPost]
        public IActionResult News(News news)
        {
            if (news is null) return BadRequest();
            news.Id = Guid.NewGuid();
            _unit.NewsRepo.Add(news);
            _unit.Save();
            return Ok(news.Id);
        }

        [HttpPost]
        public IActionResult Media(MediaLink link)
        {
            if (link is null) link = new MediaLink();
            link.Id = Guid.NewGuid();
            _unit.MediaLinkRepo.Add(link);
            _unit.Save();
            return Ok(link.Id);
        }

        public IActionResult EventDelete(Guid id) 
        {
            Event @event = _unit.EventRepo.ReadFirst(e => e.Id == id);
            if (@event is null)
            {
                //toastr
            }
            else 
            {
                //toastr
                _fileHandler.Delete(@event.ImgPath);
                _unit.EventRepo.Remove(@event);
                _unit.Save();
            }
            return ToHome(/*toastr msg*/);
        }
        public IActionResult NewsDelete(Guid id)
        {
            News news = _unit.NewsRepo.ReadFirst(n => n.Id == id);
            if (news is null) return BadRequest();
            _unit.NewsRepo.Remove(news);
            _unit.Save();
            return Ok();
        }
        public IActionResult MediaDelete(Guid id)
        {
            MediaLink link = _unit.MediaLinkRepo.ReadFirst(l => l.Id == id);
            if (link is null) return BadRequest();
            _unit.MediaLinkRepo.Remove(link);
            _unit.Save();
            return Ok();
        }

        [NonAction]
        IActionResult ToHome()
        {
            return RedirectToRoute(new RouteValueDictionary()
            {
                { "controller", "Home" },
                { "action", "Index" }
            });
        }
    }
}
