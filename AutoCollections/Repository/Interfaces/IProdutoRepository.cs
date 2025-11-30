using AutoCollections.Models;

namespace AutoCollections.Repository.Interfaces
{
    public interface IProdutoRepository
    {
        public Task<IEnumerable<Produto>> TodosProdutos();
        public Task<IEnumerable<Produto>> TodasMarcas();
        public Task<IEnumerable<Produto>> TodasCategorias();
        public Task<Produto?> ProdutosPorId(int idProduto);
        public Task<Produto?> Cadastrar(Produto produto);
        public Task<Produto?> Excluir(int id);
        public Task<Produto?> Atualizar(Produto produto);
    }
}
