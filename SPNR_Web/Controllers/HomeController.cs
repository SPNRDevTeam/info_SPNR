using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using SPNR_Web.Models.DataBase;
using SPNR_Web.Utils;
using SPNR_Web.DataAccess;

namespace SPNR_Web.Controllers
{
    public class HomeController : Controller
    {
        IUnitOfWork _unit;
        public HomeController(IUnitOfWork unit)
        {
            _unit = unit;
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