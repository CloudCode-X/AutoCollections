using AutoCollections.Models;

namespace AutoCollections.Repository.Interfaces
{
    public interface IFuncionarioRepository
    {
        public void CadastrarProduto(Produto produto);
        public Funcionario Login(string EmailFuncionario, string SenhaFuncionario);
    }
}
