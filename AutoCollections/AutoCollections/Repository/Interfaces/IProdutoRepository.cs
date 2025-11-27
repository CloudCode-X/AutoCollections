using AutoCollections.Models;

namespace AutoCollections.Repository.Interfaces
{
    public class IProdutoRepository
    {
        public Task<IEnumerable<Produto>> TodosProdutos();
        public Task<Produto?> ProdutoPorId(int idProduto);
        public Task<Produto?> Excluir(int id);
        public void Atualizar(Produto produto);
    }
}
