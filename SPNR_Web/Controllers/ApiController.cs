using Microsoft.AspNetCore.Mvc;
using SPNR_Web.DataAccess;
using SPNR_Web.Models.Api;
using SPNR_Web.Models.DataBase;

namespace SPNR_Web.Controllers
{
    public class ApiController : Controller
    {
        IUnitOfWork _unit; 
        public ApiController(IUnitOfWork unit)
        {
            _unit = unit;
        }
        [HttpGet]
        public IActionResult Events(Guid? id)
        {
            if (id is null) return Ok(
                _unit.EventRepo.ReadAll() 
                .OrderBy(e => e.DateTime)
                .Select(e => new EventResp()
                    {
                        Id = e.Id,
                        Name = e.EventName,
                        Description = e.EventDescription,
                        ImgPath = e.ImgPath
                    }));

            Event? @event = _unit.EventRepo.ReadFirst(e => e.Id == id);
            if (@event is null) return BadRequest();

            @event.Header = _unit.HeaderRepo.ReadFirst(h => h.EventId == @event.Id);

            @event.Header.Links = _unit.HeaderLinkRepo
                .ReadWhere(l => l.HeaderId == @event.Header.Id)
                .OrderBy(l => l.DisplayOrder)
                .ToList();

            @event.Blocks = _unit.BlockRepo
                .ReadWhere(b => b.EventId == @event.Id)
                .OrderBy(b => b.DisplayOrder)
                .ToList();

            @event.SubEvents = _unit.SubEventRepo
                .ReadWhere(s => s.EventId == @event.Id)
                .OrderBy(s => s.Start)
                .ToList();

            return Ok(@event);
        }
        [HttpGet]
        public IActionResult News(int n)
        {
            return Ok(
                _unit.NewsRepo
                .ReadAll()
                .OrderBy(n => n.PublicationTime)
                .Take(n));
        }
        [HttpGet]
        public IActionResult Media(int n)
        {
            return Ok(
                _unit.MediaLinkRepo
                .ReadAll()
                .OrderBy(l => l.CreationTime)
                .Take(n));
        }
    }
}
