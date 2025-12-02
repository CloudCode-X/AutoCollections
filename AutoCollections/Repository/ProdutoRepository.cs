using Dapper;
using MySql.Data.MySqlClient;
using AutoCollections.Models;
using AutoCollections.Repository.Interfaces;

namespace AutoCollections.Repository
{
    public class ProdutoRepository : IProdutoRepository
    {
        private readonly string _connectionString;

        public ProdutoRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection"); ;
        }

        public async Task<IEnumerable<Produto>> TodosProdutos()
        {
            using var connection = new MySqlConnection(_connectionString);
            var sql = "SELECT IdProduto, IdFornecedor, NomeProduto, PrecoUnitario, Escala, Peso, Material, QuantidadePecas, QuantidadeEstoque, QuantidadeMinima, Descricao, Categoria, Marca FROM tbProduto";
            return await connection.QueryAsync<Produto>(sql);
        }

        public async Task<IEnumerable<Produto>> TodosProdutosCatalogo()
        {
            using var connection = new MySqlConnection(_connectionString);
            var sql = "@SELECT p.IdProduto, p.NomeProduto, p.PrecoUnitario, (SELECT ImagemURL i WHERE i.IdProduto = p.IdProduto LIMIT 1) AS ImagemURL FROM tbProduto p";
            return await connection.QueryAsync<Produto>(sql);
        }

        public async Task<Produto?> ProdutosPorId(int idProduto)
        {
            using var connection = new MySqlConnection(_connectionString);
            var sql = "SELECT * FROM tbProduto WHERE IdProduto = @IdProduto";
            return await connection.QueryFirstOrDefaultAsync<Produto>(sql, new { IdProduto = idProduto });
        }

        public async Task<Produto?> Cadastrar(Produto produto)
        {
            using var connection = new MySqlConnection(_connectionString);
            var sql = "INSERT INTO tbProduto(IdFornecedor, NomeProduto, PrecoUnitario, Escala, Peso, Material, QuantidadePecas, QuantidadeEstoque, QuantidadeMinima, Descricao, Categoria, Marca, CorProduto, ImagemURL)" +
                "VALUES (@IdFornecedor, @NomeProduto, @PrecoUnitario, @Escala, @Peso, @Material, @QuantidadePecas, @QuantidadeEstoque, @QuantidadeMinima, @Descricao, @Categoria, Marca, @CorProduto, @ImagemURL)";
            var novoProduto = await connection.QueryFirstOrDefaultAsync<Produto>(sql, produto);
            return novoProduto;
        }

        public async Task<Produto?> Excluir(int idProduto)
        {
            using var connection = new MySqlConnection(_connectionString);
            var produto = await connection.QueryFirstOrDefaultAsync<Produto>(
                "SELECT * FROM tbProduto WHERE IdProduto = @IdProduto",
                new { IdProduto = idProduto }
            );

            if (produto == null)
            {
                return null;
            }

            await connection.ExecuteAsync(
                "DELETE FROM tbProduto WHERE IdProduto = @IdProduto",
                new { IdProduto = idProduto }
            );

            return produto;
        }
        public async Task<bool> Atualizar(Produto produto)
        {
            {
                using var connection = new MySqlConnection(_connectionString);

                var sql = "UPDATE tbPoduto SET IdFornecedor = @IdFornecedor, NomeProduto = @NomeProduto, PrecoUnitario = @PrecoUnitario, Escala = @Escala, Peso = @Peso, Material = @Material, QuantidadePecas = @QuantidadePecas, QuantidadeEstoque = @QuantidadeEstoque, QuantidadeMinima = @QuantidadeMinima, Descricao = @Descricao, Categoria = @Categoria, Marca = @Marca, CorProduto = @CorProduto, ImagemURL = @ImagemURL WHERE IdProduto = @IdProduto";

                int linhasAfetadas = await connection.ExecuteAsync(sql, produto);

                return linhasAfetadas > 0;
            }
        }

        Task<Produto?> IProdutoRepository.Atualizar(Produto produto)
        {
            throw new NotImplementedException();
        }
    }
}