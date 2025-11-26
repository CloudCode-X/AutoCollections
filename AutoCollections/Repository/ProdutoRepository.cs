using MySql.Data.MySqlClient;
using Dapper;
using AutoCollections.Models;

namespace AutoCollections.Repository
{
    public class ProdutoRepository
    {
        private readonly string _connectionString;

        public ProdutoRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task<IEnumerable<Produto>> TodosProdutos()
        {
            using var connection = new MySqlConnection(_connectionString);
            var sql = "SELECT IdProduto, IdFornecedor, NomeProduto, PrecoUnitario, Escala, Peso, Material, TipoProduto, QuantidadePecas, QuantidadeEstoque, QuantidadeMinima, Descricao, IdCategoria, IdMarca FROM tbProduto";
            return await connection.QueryAsync<Produto>(sql);
        }


        public async Task<Produto?> ProdutosPorId(int id)
        {
            using var connection = new MySqlConnection(_connectionString);
            var sql = "SELECT IdProduto, IdFornecedor, NomeProduto, PrecoUnitario, Escala, Peso, Material, TipoProduto, QuantidadePecas, QuantidadeEstoque, QuantidadeMinima, Descricao, IdCategoria, IdMarca, CaminhoImagem WHERE IdProduto = @IdProduto";
            return await connection.QueryFirstOrDefaultAsync<Produto>(sql, new { Id = id });
        }


    }
}