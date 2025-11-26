using AutoCollections.Models;
using MySql.Data.MySqlClient;

namespace AutoCollections.Repository
{
    public class CaminhoImagemRepository
    {
        private readonly string _connectionString;

        public CaminhoImagemRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task<IEnumerable<ImagemProduto>> TodosCaminhos()
        {
            using var connection = new MySqlConnection(_connectionString);
            var sql = "SELECT IdProduto, IdFornecedor, NomeProduto, PrecoUnitario, Escala, Peso, Material, TipoProduto, QuantidadePecas, QuantidadeEstoque, QuantidadeMinima, Descricao, IdCategoria, IdMarca FROM tbProduto";
            return await connection.QueryAsync<ImagemProduto>(sql);
        }


        public async Task<Produto?> CaminhosPorId(int id)
        {
            using var connection = new MySqlConnection(_connectionString);
            var sql = "SELECT IdProduto, IdFornecedor, NomeProduto, PrecoUnitario, Escala, Peso, Material, TipoProduto, QuantidadePecas, QuantidadeEstoque, QuantidadeMinima, Descricao, IdCategoria, IdMarca WHERE IdProduto = @IdProduto";
            return await connection.QueryFirstOrDefaultAsync<ImagemProduto>(sql, new { Id = id });
        }


    }
}