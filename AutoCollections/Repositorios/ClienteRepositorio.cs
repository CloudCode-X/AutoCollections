using MySql.Data.MySqlClient;
using AutoCollections.Models;
using AutoCollections.Repositorios.Interface;
using System.Data;

namespace AutoCollections.Repositorios
{
    public class ClienteRepositorio : InterfaceCliente
    {
        private readonly string _connectionString;

        public ClienteRepositorio(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
        public void CadastrarCliente(Cliente cliente)
        {
            using (var conexao = new MySqlConnection(_connectionString))
            {
                conexao.Open();
                MySqlCommand comand = new MySqlCommand("insert into tbCliente (CPF_Cliente, Nome_Cliente, Senha_Cliente, DataNascimento_Cliente, Telefone_Cliente, Email_Cliente, CEP_Cliente) values" +
                    " (@CPF_Cliente, @Nome_Cliente, @Senha_Cliente, @DataNascimento_Cliente, @Telefone_Cliente, @Email_Cliente, @CEP_Cliente)"), conexao);

                comand.Parameters.Add("@CPF_Cliente", MySqlDbType.VarChar).Value = cliente.CPFCliente;
                comand.Parameters.Add("@Nome_Cliente", MySqlDbType.VarChar).Value = cliente.NomeCliente;
                comand.Parameters.Add("@Senha_Cliente", MySqlDbType.VarChar).Value = cliente.SenhaCliente;
                comand.Parameters.Add("@DataNascimento_Cliente", MySqlDbType.Date).Value = cliente.DataNascimento;
                comand.Parameters.Add("@Telefone_Cliente", MySqlDbType.VarChar).Value = cliente.TelefoneCliente;
                comand.Parameters.Add("@Email_Cliente", MySqlDbType.VarChar).Value = cliente.EmailCliente;
                comand.Parameters.Add("@CEP_Cliente", MySqlDbType.VarChar).Value = cliente.CEPCliente;

                comand.ExecuteNonQuery();
                conexao.Close();
            }
        }
    }
}
