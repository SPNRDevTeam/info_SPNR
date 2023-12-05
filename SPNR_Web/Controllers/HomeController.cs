using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using SPNR_Web.Models.DataBase;

namespace SPNR_Web.Controllers
{
    public class HomeController : Controller
    {
        public HomeController()
        {
        }

        public IActionResult Index(int? id)
        {
            return View();
        }
        [Authorize]
        public IActionResult Add()
        {
            return View();
        }

        public IActionResult News()
        {
            return View();
        }

        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(User u)
        {
            if (HttpContext.Session.GetString("UserName") == null)
            {

                if (ModelState.IsValid)
                {
                    if (true)
                    {
                        HttpContext.Session.SetString("UserName", "Deimos");
                        return RedirectToAction("Index");
                    }
                }
            }
            else
            {



                return RedirectToAction("Login");
            }
            return View();
        }
    }
}