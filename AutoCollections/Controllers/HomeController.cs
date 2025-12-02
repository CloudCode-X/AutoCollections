using AutoCollections.Models;
using AutoCollections.Repository.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace AutoCollections.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IProdutoRepository _produtoRepository;

        public HomeController(ILogger<HomeController> logger, IProdutoRepository produtoRepository)
        {
            _logger = logger;
            _produtoRepository = produtoRepository;
        }

        public async Task<IActionResult> Index()
        {
            var produtos = await _produtoRepository.TodosProdutos();
            return View(produtos);
        }

        public IActionResult Login()
        {
            return View();
        }

        public IActionResult LoginColaborador()
        {
            return View();
        }

        


        public async  Task<IActionResult> Produto(int id)
        {
            var produto = await _produtoRepository.ProdutosPorId(id);

            if (produto == null)
                return NotFound();

            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
