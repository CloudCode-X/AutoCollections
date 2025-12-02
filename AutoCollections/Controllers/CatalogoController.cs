using AutoCollections.Models;
using AutoCollections.Repository.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace AutoCollections.Controllers
{
    public class CatalogoController : Controller
    {
        private readonly IProdutoRepository _repo;

        public CatalogoController(IProdutoRepository repo)
        {
            _repo = repo;
        }

        public async Task<IActionResult> Catalogo()
        {
            var produtos = await _repo.TodosProdutosCatalogo();

            var viewModel = produtos.Select(p => new ProdutoCatalogoViewModel
            {
                IdProduto = p.IdProduto,
                NomeProduto = p.NomeProduto,
                PrecoUnitario = p.PrecoUnitario,
                ImagemURL = p.ImagemURL
            }).ToList();

            return View(viewModel);
        }
    }
}
