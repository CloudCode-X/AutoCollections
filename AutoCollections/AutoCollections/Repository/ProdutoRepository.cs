using Dapper;
using MySql.Data.MySqlClient;
using AutoCollections.Models;
using AutoCollections.Repository.Interfaces;

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
            var sql = "SELECT IdProduto, IdFornecedor, NomeProduto, PrecoUnitario, Escala, Peso, Material, TipoProduto, QuantidadePecas, QuantidadeEstoque, QuantidadeMinima, Descricao, IdCategoria, IdMarca WHERE IdProduto = @IdProduto";
            return await connection.QueryFirstOrDefaultAsync<Produto>(sql, new { Id = id });
        }

        public async Task<Produto?> Excluir(int id)
        {
            using var connection = new MySqlConnection(_connectionString);
            var produto = await connection.QueryFirstOrDefaultAsync<Produto>(
                "SELECT * FROM tbProduto WHERE IdProduto = @IdProduto",
                new { Id = id }
            );

            if (produto == null)
            {
                return null;
            }

            await connection.ExecuteAsync(
                "DELETE FROM tbProduto WHERE IdProduto = @IdProduto",
                new { Id = id }
            );

            return produto;
        }
        public void Atualizar(Produto produto)
        {
            /*try
            {

                using (var connection = new MySqlConnection(_connectionString))
                {
                    connection.Open();
                    MySqlCommand cmd = new MySqlCommand("update tbProduto set NomeProduto=@NomeProduto, Descricao=@Descricao, PrecoUnitario=@PrecoUnitario,  CaminhoImagem=@CaminhoImagem, " +
                        " Quantidade=@Quantidade, Categoria=@Categoria WHERE IdProduto=@IdProduto", connection);

                    cmd.Parameters.Add("@Nome", MySqlDbType.VarChar).Value = produto.NomeProduto;
                    cmd.Parameters.Add("@Descricao", MySqlDbType.VarChar).Value = produto.Descricao;
                    cmd.Parameters.Add("@Preco", MySqlDbType.VarChar).Value = produto.PrecoUnitario;
                    cmd.Parameters.Add("@ImageUrl", MySqlDbType.VarChar).Value = produto.CaminhoImagem;
                    cmd.Parameters.Add("@Quantidade", MySqlDbType.VarChar).Value = produto.Quantidade;
                    cmd.Parameters.Add("@Categoria", MySqlDbType.VarChar).Value = produto.IdCategoria;
                    cmd.ExecuteNonQuery();
                    connection.Close();
                }

            }
            catch (MySqlException ex)
            {
                throw new Exception("Erro no banco ao atualizar cliente" + ex.Message);
            }
            catch (Exception ex)
            {
                throw new Exception("Erro na aplicação ao atualizar cliente" + ex.Message);
            }*/
        }
    }
}