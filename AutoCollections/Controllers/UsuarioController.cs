using AutoCollections.Models;
using AutoCollections.Repository;
using AutoCollections.Repository.Interfaces;
using Microsoft.AspNetCore.Mvc;
using MySqlX.XDevAPI;

namespace AutoCollections.Controllers
{
    public class UsuarioController : Controller
    {
        private IUsuarioRepository _IUsuarioRepo;

        public UsuarioController(IUsuarioRepository UsuarioRepo)
        {
            _IUsuarioRepo = UsuarioRepo;
        }
        public IActionResult Index()
        {
            return View(/*_IUsuarioRepo.ObterUsuario(IdUsuario)*/);
        }
        [HttpGet]
        public IActionResult CadastrarUsuario()
        {

            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult CadastrarUsuario(Usuario usuario)
        {
            if (ModelState.IsValid)
            {
                _IUsuarioRepo.CadastrarUsuario(usuario);
                TempData["Mensagem"] = "Conta criada com sucesso!";
                TempData["TipoMensagem"] = "success";


                return RedirectToAction("Index", "Home");
            }
            return View(usuario);
        }

        [HttpGet]
        public IActionResult Login()
        {
            ViewBag.UserId = HttpContext.Session.GetInt32("UserId");
            ViewBag.Nome = HttpContext.Session.GetString("UserNome");
            ViewBag.Email = HttpContext.Session.GetString("UserEmail");

            return View();
        }
        [HttpPost]
        public IActionResult Login(string Email, string Senha, Usuario usuario)
        {
            var result = _IUsuarioRepo.Login(Email, Senha);

            if (result == null)
            {
                TempData["Mensagem"] = "Email/Senha incorretos";
                TempData["TipoMensagem"] = "warning";
                return RedirectToAction("Login", "Usuario");
            }

            HttpContext.Session.SetInt32("UserId", result.IdUsuario);
            HttpContext.Session.SetString("UserEmail", result.Email);
            HttpContext.Session.SetString("UserSenha", result.Senha);

            return RedirectToAction("Login", "Usuario");
        }
    }
}
