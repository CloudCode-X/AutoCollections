using AutoCollections.Models;

namespace AutoCollections.Repository.Interfaces
{
    public interface IProdutoRepository
    {
        public Task<IEnumerable<Produto>> TodosProdutos();

        public Task<IEnumerable<Produto>> TodosProdutosCatalogo();
        public Task<Produto?> ProdutosPorId(int id);
        public Task<Produto?> Cadastrar(Produto produto);
        public Task<Produto?> Excluir(int id);
        public Task<Produto?> Atualizar(Produto produto);
    }
}
