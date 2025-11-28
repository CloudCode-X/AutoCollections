using AutoCollections.Models;

namespace AutoCollections.Repository.Interfaces
{
    public interface IProdutoRepository
    {
        public Task<IEnumerable<Produto>> TodosProdutos();
        public Task<Produto?> ProdutosPorId(int idProduto);
        public Task<Produto?> Excluir(int id);
        public void Atualizar(Produto produto);
    }
}
