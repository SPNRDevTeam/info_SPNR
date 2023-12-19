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
        public IActionResult News(Guid? id)
        {
            if (id is null) return Ok(
                _unit.NewsRepo.ReadAll() 
                .OrderBy(n => n.PublicationTime)
                .Select(n => new NewsResp()
                    {
                        Id = n.Id,
                        Name = n.Name,
                        Description = n.Description,
                        DateTime = n.PublicationTime.ToString("u"),
                        //Text = n.Text,
                        ImgPath = n.ImgPath == null ? "null" : n.ImgPath 
                    }));

            News? @news = _unit.NewsRepo.ReadFirst(n => n.Id == id);
            if (@news is null) return BadRequest();

            return Ok(@news);
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
