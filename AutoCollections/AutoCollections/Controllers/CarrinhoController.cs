using Microsoft.AspNetCore.Mvc;

namespace AutoCollections.Controllers
{
    public class CarrinhoController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
