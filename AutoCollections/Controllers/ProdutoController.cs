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
            if (produto == null)
                return NotFound();

            var viewModel = new ProdutoViewModel
            {
                NomeProduto = produto.NomeProduto,
                PrecoUnitario = produto.PrecoUnitario,
                Descricao = produto.Descricao,
                ImagemURL = new List<string>
                {
                    "https://limahobbies.vteximg.com.br/arquivos/ids/228353/Miniatura-Carro-Lamborghini-Countack-1-64-Maisto-15541.jpg?v=638670416111000000",
                    "https://limahobbies.vteximg.com.br/arquivos/ids/228353/Miniatura-Carro-Lamborghini-Countack-1-64-Maisto-15541.jpg?v=638670416111000000",
                    "https://limahobbies.vteximg.com.br/arquivos/ids/228353/Miniatura-Carro-Lamborghini-Countack-1-64-Maisto-15541.jpg?v=638670416111000000"
                }
            };

            return View(viewModel);
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
