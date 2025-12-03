using AutoCollections.Models;
using AutoCollections.Repository;
using AutoCollections.Repository.Interfaces;
using Microsoft.AspNetCore.Mvc;

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
            {
                var model = new Produto
                {
                    IdProduto = produto.IdProduto,
                    NomeProduto = produto.NomeProduto,
                    PrecoUnitario = produto.PrecoUnitario,
                    Descricao = produto.Descricao
                };

                return View(model);
            }
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
