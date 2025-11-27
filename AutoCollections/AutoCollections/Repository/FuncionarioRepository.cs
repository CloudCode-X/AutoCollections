using Dapper;
using MySql.Data.MySqlClient;
using AutoCollections.Models;
using AutoCollections.Repository.Interfaces;
using System.Data;
using System.Text;

namespace AutoCollections.Repository
{
    public class FuncionarioRepository : IFuncionarioRepository
    {
        private readonly string _connectionString;

        public FuncionarioRepository(IConfiguration conf)
        {
            _connectionString = conf.GetConnectionString("DefaultConnection");

        }
        public void CadastrarProduto(Produto produto)
        {
            using (var connection = new MySqlConnection(_connectionString))
            {
                connection.Open();
                MySqlCommand comd = new MySqlCommand("sp_CadastroProduto(@NomeProduto, @PrecoUnitario, @Escala, @Peso, @Material, @TipoProduto, @QuantidadePecas, @QuantidadeEstoque, @QuantidadeMinima, @Descricao, @IdMarca, @IdCategoria, @CorProduto)", connection);
                comd.Parameters.Add("@NomeProduto", MySqlDbType.VarChar).Value = produto.NomeProduto;
                comd.Parameters.Add("@PrecoUnitario", MySqlDbType.Decimal).Value = produto.PrecoUnitario;
                comd.Parameters.Add("@Escala", MySqlDbType.VarChar).Value = produto.Escala;
                comd.Parameters.Add("@Peso", MySqlDbType.Int32).Value = produto.Peso;
                comd.Parameters.Add("@Material", MySqlDbType.VarChar).Value = produto.Material;
                comd.Parameters.Add("@TipoProduto", MySqlDbType.VarChar).Value = produto.TipoProduto;
                comd.Parameters.Add("@QuantidadePecas", MySqlDbType.VarChar).Value = produto.QuantidadePecas;
                comd.Parameters.Add("@QuantidadeEstoque", MySqlDbType.VarChar).Value = produto.QuantidadeEstoque;
                comd.Parameters.Add("@QuantidadeMinima", MySqlDbType.VarChar).Value = produto.QuantidadeMinima;
                comd.Parameters.Add("@Descricao", MySqlDbType.VarChar).Value = produto.Descricao;
                comd.Parameters.Add("@IdMarca", MySqlDbType.VarChar).Value = produto.IdMarca;
                comd.Parameters.Add("@IdCategoria", MySqlDbType.VarChar).Value = produto.IdCategoria;
                comd.Parameters.Add("@CorProduto", MySqlDbType.VarChar).Value = produto.CorProduto;
                comd.ExecuteNonQuery();
                connection.Close();
            }
        }

        public Funcionario Login(string EmailFuncionario, string SenhaFuncionario)
        {
            using (var connection = new MySqlConnection(_connectionString))
            {
                connection.Open();
                MySqlCommand cmd = new MySqlCommand("SELECT IdFuncionario, EmailFuncionario, SenhaFuncionario FROM tbFuncionario WHERE EmailFuncionario=@EmailFuncionario AND SenhaFuncionario=@SenhaFuncionario", connection);
                cmd.Parameters.AddWithValue("@EmailFuncionario", EmailFuncionario);
                cmd.Parameters.AddWithValue("@Senha", SenhaFuncionario);

                using (MySqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {

                        Funcionario funcionario = new Funcionario
                        {
                            SenhaFuncionario = (string)dr["SenhaFuncionario"],
                            IdFuncionario = (int)dr["IdFuncionario"],
                            EmailFuncionario = (string)dr["EmailFuncionario"]
                        };
                        return funcionario;

                    }
                    //MySqlDataAdapter da = new MySqlDataAdapter(cmd);



                }
            }
            return null;
        }

    }
}
