using MySql.Data.MySqlClient;
using AutoCollections.Models;
using AutoCollections.Repository.Interfaces;
using MySqlX.XDevAPI;
using System.Data;

namespace AutoCollections.Repository
{
    public class UsuarioRepository : IUsuarioRepository
    {
        private readonly string _connectionString;
        IConfiguration _config;

        public UsuarioRepository(IConfiguration conf)
        {
            _connectionString = conf.GetConnectionString("DefaultConnection");
            _config = conf;
        }

        public void CadastrarUsuario(Usuario usuario)
        {
            using (var connection = new MySqlConnection(_connectionString))
            {
                connection.Open();
                MySqlCommand comand = new MySqlCommand("CALL sp_CadastrarUsuario(@CPF, @Nome, @DataNascimento, @Telefone, @Email, @Senha, @CEP)", connection);

                comand.Parameters.Add("@CPF", MySqlDbType.String).Value = usuario.CPF;
                comand.Parameters.Add("@Nome", MySqlDbType.VarChar).Value = usuario.Nome;
                comand.Parameters.Add("@Nome", MySqlDbType.Date).Value = usuario.DataNascimento;
                comand.Parameters.Add("@Telefone", MySqlDbType.Int32).Value = usuario.Telefone;
                comand.Parameters.Add("@Email", MySqlDbType.VarChar).Value = usuario.Email;
                comand.Parameters.Add("@Senha", MySqlDbType.VarChar).Value = usuario.Senha;
                comand.Parameters.Add("@CEP", MySqlDbType.Int32).Value = usuario.CEP;

                comand.ExecuteNonQuery();
                connection.Close();
            }
        }
        public Usuario ObterUsuario(int IdUsuario)
        {
            using (var connection = new MySqlConnection(_connectionString))
            {
                connection.Open();
                MySqlCommand cmd = new MySqlCommand("select * from tbUsuario WHERE IdUsuario=@IdUsuario;", connection);
                cmd.Parameters.AddWithValue("@IdUsuario", IdUsuario);

                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                MySqlDataReader dr;

                Usuario usuario = new Usuario();
                dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                while (dr.Read())
                {
                    usuario.IdUsuario = (Int32)(dr["IdUsuario"]);
                    usuario.Nome = (string)(dr["Nome"]);
                    usuario.Telefone = (Int32)(dr["Telefone"]);
                    usuario.Email = (string)(dr["Email"]);
                    usuario.Senha = (string)(dr["Senha"]);

                }
                return usuario;
            }
        }

        public Usuario Login(string Email, string Senha)
        {
            using (var connection = new MySqlConnection(_connectionString))
            {
                connection.Open();
                MySqlCommand cmd = new MySqlCommand("SELECT IdUsuario, Email, Senha FROM tbUsuario WHERE Email=@Email AND Senha=@Senha", connection);
                cmd.Parameters.AddWithValue("@Email", Email);
                cmd.Parameters.AddWithValue("@Senha", Senha);

                using (MySqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {

                        Usuario usuario = new Usuario
                        {
                            Senha = (string)dr["Senha"],
                            IdUsuario = (int)dr["IdUsuario"],
                            Email = (string)dr["Email"]
                        };
                        return usuario;

                    }
                }
                return null;
            }
        }
    }
}
