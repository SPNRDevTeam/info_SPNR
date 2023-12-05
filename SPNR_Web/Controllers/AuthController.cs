using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using SPNR_Web.DataAccess;
using SPNR_Web.Models.DataBase;

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

        public IActionResult Login()
        {
            return View();
        }

        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return ToHome();
        }

        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(User user)
        {
            User dbUser = _unit.UserRepo.ReadFirst(u => u.Login == user.Login);
            if (dbUser == null)
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
