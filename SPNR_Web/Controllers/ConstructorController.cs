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

        public IActionResult News(Guid? id)
        {
            if (id is null) return View(new News());
            News? news = _unit.NewsRepo.ReadFirst(n => n.Id == id);
            if (news is null) return ToHome();
            return View(@news);
        }
        public IActionResult Media(Guid? id)
        {
            if (id is null) return View(new MediaLink());
            MediaLink? link = _unit.MediaLinkRepo.ReadFirst(l => l.Id == id);
            if (link is null) return ToHome();
            return View(link);
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
        public IActionResult News(News news, IFormFile? file)
        {
            if (news.Id == Guid.Empty)
            {
                news.Id = Guid.NewGuid();
                if (file is not null) news.ImgPath = _fileHandler.Save(file);
                _unit.NewsRepo.Add(@news);
            }
            else
            {
                if (file is not null)
                {
                    _fileHandler.Delete(news.ImgPath);
                    news.ImgPath = _fileHandler.Save(file);
                }
                _unit.NewsRepo.Update(news);
            }
            _unit.Save();
            return ToHome();
        }

        [HttpPost]
        public IActionResult Media(MediaLink link)
        {
            if (link.Id == Guid.Empty)
            {
                link.Id = Guid.NewGuid();
                _unit.MediaLinkRepo.Add(link);
            }
            else
            {
                _unit.MediaLinkRepo.Update(link);
            }
            _unit.Save();
            return ToHome();
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
            if (news is null)
            {

            }
            else
            {
                _fileHandler.Delete(news.ImgPath);
                _unit.NewsRepo.Remove(news);
                _unit.Save();
            }
            return ToHome();
        }
        public IActionResult MediaDelete(Guid id)
        {
            MediaLink link = _unit.MediaLinkRepo.ReadFirst(l => l.Id == id);
            if (link is null)
            {
                    
            }
            else
            {
                _unit.MediaLinkRepo.Remove(link);
                _unit.Save();
            }
            return ToHome();
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
