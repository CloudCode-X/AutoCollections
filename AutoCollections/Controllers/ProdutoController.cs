using Microsoft.AspNetCore.Mvc;
using AutoCollections.Models;

namespace AutoCollections.Controllers
{
    public class ProdutoController : Controller
    {
        public IActionResult Index()
        { 
            return View();
        }
    }
}
