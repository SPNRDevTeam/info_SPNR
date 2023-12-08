using Microsoft.AspNetCore.Mvc;
using SPNR_Web.DataAccess;
using SPNR_Web.Models.DataBase;

namespace SPNR_Web.Controllers
{
    public class ConstructorController : Controller
    {
        IUnitOfWork _unit;
        public ConstructorController(IUnitOfWork unit) 
        {
            _unit = unit;
        }
        public IActionResult Event()
        {
            return View();
        }

        public IActionResult News()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Event([FromBody] Event @event)
        {
            if (@event is null || @event.Header is null) return BadRequest();

            @event.Id = Guid.NewGuid();
            _unit.EventRepo.Add(@event);

            Header header = @event.Header;
            header.Id = Guid.NewGuid();
            header.EventId = @event.Id;
            _unit.HeaderRepo.Add(header);

            foreach (HeaderLink link in header.Links)
            {
                link.Id = Guid.NewGuid();
                link.HeaderId = header.Id;
                _unit.HeaderLinkRepo.Add(link);
            }

            foreach (TextBlock block in @event.Blocks)
            {
                block.Id = Guid.NewGuid();
                block.EventId = @event.Id;
                _unit.BlockRepo.Add(block);
            }

            foreach (SubEvent sub in @event.SubEvents)
            {
                sub.Id = Guid.NewGuid();
                sub.EventId = @event.Id;
                _unit.SubEventRepo.Add(sub);
            }

            _unit.Save();

            return Ok(@event.Id);
        }

        [HttpPost]
        public IActionResult News([FromBody] News news)
        {
            if (news is null) return BadRequest();
            news.Id = Guid.NewGuid();
            _unit.NewsRepo.Add(news);
            _unit.Save();
            return Ok(news.Id);
        }

        [HttpPost]
        public IActionResult Media([FromBody] MediaLink link)
        {
            if (link is null) link = new MediaLink();
            link.Id = Guid.NewGuid();
            _unit.MediaLinkRepo.Add(link);
            _unit.Save();
            return Ok(link.Id);
        }

        [HttpDelete]
        public IActionResult Event(Guid id) 
        {
            Event @event = _unit.EventRepo.ReadFirst(e => e.Id == id);
            if (@event is null) return BadRequest();

            Header header = _unit.HeaderRepo.ReadFirst(h => h.EventId == id);
            IEnumerable<HeaderLink> links = _unit.HeaderLinkRepo.ReadWhere(hl => hl.HeaderId == header.Id);
            IEnumerable<TextBlock> blocks = _unit.BlockRepo.ReadWhere(b => b.EventId == id);
            IEnumerable<SubEvent> subs = _unit.SubEventRepo.ReadWhere(s => s.EventId == id);

            _unit.SubEventRepo.RemoveRange(subs);
            _unit.BlockRepo.RemoveRange(blocks);
            _unit.HeaderLinkRepo.RemoveRange(links);
            _unit.HeaderRepo.Remove(header);
            _unit.EventRepo.Remove(@event);
            _unit.Save();

            return Ok();
        }
        [HttpDelete]
        public IActionResult News(Guid id)
        {
            News news = _unit.NewsRepo.ReadFirst(n => n.Id == id);
            if (news is null) return BadRequest();
            _unit.NewsRepo.Remove(news);
            _unit.Save();
            return Ok();
        }
        [HttpDelete]
        public IActionResult Media(Guid id)
        {
            MediaLink link = _unit.MediaLinkRepo.ReadFirst(l => l.Id == id);
            if (link is null) return BadRequest();
            _unit.MediaLinkRepo.Remove(link);
            _unit.Save();
            return Ok();
        }
    }
}
