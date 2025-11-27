using Microsoft.AspNetCore.Mvc;

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
