using AutoCollections.Models;

namespace AutoCollections.Repository.Interfaces
{
    public interface IUsuarioRepository
    {
        public void CadastrarUsuario(Usuario usuario);
        public Usuario ObterUsuario(int IdUsuario);
        public Usuario Login(string Email, string Senha);
    }
}
