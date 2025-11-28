using AutoCollections.Models;
using Microsoft.AspNetCore.Mvc;
using AutoCollections.Repository.Interfaces;

namespace AutoCollections.Controllers
{
    public class FuncionarioController : Controller
    {
        private IFuncionarioRepository _IFuncionarioRepo;
        private IProdutoRepository _IProdutoRepo;

        public FuncionarioController(IFuncionarioRepository FuncionarioRepo, IProdutoRepository ProdutoRepo)
        {
            _IFuncionarioRepo = FuncionarioRepo;
            _IProdutoRepo = ProdutoRepo;
        }
        public IActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public async Task<IActionResult> CadastrarProduto()
        {
            var produtos = await _produtoRepository.TodosProdutos();
            return View(produtos);
        }
        [HttpPost]
        public async Task<IActionResult> CadastrarProduto(Produto produto)
        {

            if (ModelState.IsValid)
            {
                _IFuncionarioRepository.CadastrarProduto(produto);
            }

            var produtos = await _produtoRepository.TodosProdutos();
            return View(produtos);
        }
        [HttpPost]
        public async Task<IActionResult> Excluir(int id)
        {
            var produtoExcluido = await _produtoRepository.Excluir(id);

            if (produtoExcluido == null)
            {
                return NotFound();
            }
            return RedirectToAction("CadastrarP");
        }
        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Login(string Email, string Senha, Funcionario funcionario)
        {
            if (string.IsNullOrWhiteSpace(Email) || string.IsNullOrWhiteSpace(Senha))
            {
                TempData["Mensagem"] = "Preencha todos os campos.";
                TempData["TipoMensagem"] = "warning";
                return RedirectToAction("Login", "Funcionario");
            }
            var result = _IFuncionarioRepository.Login(Email, Senha);


            if (result == null)
            {
                TempData["Mensagem"] = "Email/Senha incorretos";
                TempData["TipoMensagem"] = "warning";
                return RedirectToAction("Login", "Funcionario");
            }

            HttpContext.Session.SetInt32("UserId", funcionario.IdFuncionario);
            HttpContext.Session.SetString("UserEmail", funcionario.EmailFuncionario);
            HttpContext.Session.SetString("UserSenha", funcionario.SenhaFuncionario);
            return RedirectToAction("CadastrarProduto", "Funcionario");
        }
    }
}
