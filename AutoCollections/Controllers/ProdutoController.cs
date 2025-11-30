using Microsoft.AspNetCore.Mvc;
using AutoCollections.Models;
using AutoCollections.Repository.Interfaces;

namespace AutoCollections.Controllers
{
    public class ProdutoController : Controller
    {
        private readonly IProdutoRepository _repo;


        public ProdutoController(IProdutoRepository repo)
        {
            _repo = repo;
        }

        public async Task<IActionResult> Index()
        {
            var produtos = await _repo.TodosProdutos();
            return View(produtos);
        }

        public async Task<IActionResult> Detalhes(int id)
        {
            var produto = await _repo.ProdutosPorId(id);
            return View(produto);
        }

        [HttpPost]
        public IActionResult Cadastrar(Produto p)
        {
            _repo.Cadastrar(p);
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> Deletar(int id)
        {
            var produto = await _repo.Excluir(id);
            return RedirectToAction("Index");
        }
    }
}
