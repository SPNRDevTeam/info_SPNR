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
                        Name = e.Name,
                        Description = e.Description,
                        DateTime = e.DateTime.ToString("u"),
                        Text = e.Text,
                        ImgPath = e.ImgPath == null ? "null" : e.ImgPath 
                    }));

            Event? @event = _unit.EventRepo.ReadFirst(e => e.Id == id);
            if (@event is null) return BadRequest();

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
