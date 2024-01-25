using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using SPNR_Web.DataAccess;
using SPNR_Web.Models.DataBase;
using SPNR_Web.Utils;

namespace SPNR_Web.Controllers
{
    public class AuthController : Controller
    {
        IUnitOfWork _unit;
        PasswordHasher<User> _hasher = new PasswordHasher<User>();
        public AuthController(IUnitOfWork unitOfWork) 
        {
            _unit = unitOfWork;
        }
        public new IActionResult Unauthorized()
        {
            TempData["error"] = "Авторизуйтесь для доступа к этой функции";
            return RedirectToAction("Login");
        }
        public IActionResult Login()
        {
            return View();
        }
        [SessionAuthFilter]
        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return ToHome();
        }
        [SessionAuthFilter]
        public IActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Login(User user)
        {
            User dbUser = _unit.UserRepo.ReadFirst(u => u.Login == user.Login);
            if (dbUser is null)
            {
                ModelState.AddModelError("", "Login not registered");
            }
            else if (_hasher.VerifyHashedPassword(dbUser, dbUser.Password, user.Password) == PasswordVerificationResult.Failed) 
            {
                ModelState.AddModelError("password", "Password invalid");
            }
            if (!ModelState.IsValid) return View();

            HttpContext.Session.SetString("Login", user.Login);
            return ToHome();
        }
        [SessionAuthFilter]
        [HttpPost]
        public IActionResult Register(User user)
        {
            if (!(_unit.UserRepo.ReadFirst(u => u.Login == user.Login) is null))
            {
                ModelState.AddModelError("login", "Login already taken");
                return View();
            }
            
            user.Password = _hasher.HashPassword(user, user.Password);
            _unit.UserRepo.Add(user);
            _unit.Save();

            return ToHome();
        }
        [SessionAuthFilter]
        public IActionResult UserPanel()
        {
            List<User> users = 
                _unit.UserRepo.ReadAll().ToList();
            return View(users);
        }
        [SessionAuthFilter]
        public IActionResult Delete(Guid id)
        {
            User? user = _unit.UserRepo.ReadFirst(u => u.Id == id);
            if (user is null)
            {
                TempData["error"] = "Такого пользователя не существует";
                return ToHome();
            }

            _unit.UserRepo.Remove(user);
            _unit.Save();
            TempData["succes"] = "Пользователь удален.";
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
