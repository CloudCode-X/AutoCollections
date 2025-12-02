using AutoCollections.Models;

namespace AutoCollections.Repository.Interfaces
{
    public interface IUsuarioRepository
    {
        Task <int> CadastrarUsuario(Usuario usuario);
        public Usuario ObterUsuario(int IdUsuario);
        public Usuario Login(string Email, string Senha);
    }
}
