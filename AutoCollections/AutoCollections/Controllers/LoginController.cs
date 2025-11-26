using Microsoft.AspNetCore.Mvc;

namespace AutoCollections.Controllers
{
    public class LoginController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult LoginColaborador()
        {
            return View();
        }
    }
}
