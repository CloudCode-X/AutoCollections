using AutoCollections.Models;
using Microsoft.AspNetCore.Mvc;

namespace AutoCollections.Controllers
{
    public class FuncionarioController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public async Task<IActionResult> CadastrarP()
        {
            var produtos = await _produtoRep.TodosProdutos();
            return View(produtos);
        }
        [HttpPost]
        public async Task<IActionResult> CadastrarP(Produto produto)
        {

            if (ModelState.IsValid)
            {
                _inFuncionario.CadastrarProduto(produto);
            }

            var produtos = await _produtoRep.TodosProdutos();
            return View(produtos);
        }
        [HttpPost]
        public async Task<IActionResult> Excluir(int id)
        {
            var produtoExcluido = await _produtoRep.Excluir(id);

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
            var result = _inFuncionario.Login(Email, Senha);


            if (result == null)
            {
                TempData["Mensagem"] = "Email/Senha incorretos";
                TempData["TipoMensagem"] = "warning";
                return RedirectToAction("Login", "Funcionario");
            }

            HttpContext.Session.SetInt32("UserId", funcionario.IdFuncionario);
            HttpContext.Session.SetString("UserEmail", funcionario.Email);
            HttpContext.Session.SetString("UserSenha", funcionario.Senha);
            return RedirectToAction("CadastrarP", "Funcionario");
        }
    }
}
