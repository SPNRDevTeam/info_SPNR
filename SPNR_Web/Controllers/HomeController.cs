using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using SPNR_Web.Models.DataBase;
using SPNR_Web.Utils;

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
        public IActionResult News()
        {
            return View();
        }
        [SessionAuthFilter]
        public IActionResult Add() 
        {
            return View();
        }
    }
}