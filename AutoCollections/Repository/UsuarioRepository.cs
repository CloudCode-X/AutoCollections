using AutoCollections.Models;
using AutoCollections.Repository.Interfaces;
using Dapper;
using MySql.Data.MySqlClient;
using MySqlX.XDevAPI;
using System.Data;
using System.Threading.Tasks;

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

        public async Task<int> CadastrarUsuario(Usuario usuario)
        {
            using (var connection = new MySqlConnection(_connectionString))
            {
                connection.Open();

                var parametros = new DynamicParameters();
                // id de saida do usuario   
                parametros.Add("vIdUsuario", dbType: DbType.Int32, direction: ParameterDirection.Output);

                parametros.Add("vCPFUsuario", usuario.CPF);
                parametros.Add("vNomeUsuario", usuario.Nome);
                parametros.Add("vDataNascimento", usuario.DataNascimento);
                parametros.Add("vTelefoneUsuario", usuario.Telefone);
                parametros.Add("vEmailUsuario", usuario.Email);
                parametros.Add("vSenhaUsuario", usuario.Senha);
                parametros.Add("vNumeroEndereco", usuario.NumeroEndereco);
                parametros.Add("vComplementoEndereco", usuario.ComplementoEndereco);
                parametros.Add("vCep", usuario.CEP);

                await connection.ExecuteAsync("sp_CadastroUsuario", parametros, commandType: CommandType.StoredProcedure);
                connection.Close();
                return parametros.Get<int>("vIdUsuario");
            }
        }
        public Usuario ObterUsuario(int IdUsuario)
        {
            using (var connection = new MySqlConnection(_connectionString))
            {
                connection.Open();
                MySqlCommand cmd = new MySqlCommand("select * from tbUsuario WHERE IdUsuario =@ IdUsuario;", connection);
                cmd.Parameters.AddWithValue("@IdUsuario", IdUsuario);

                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                MySqlDataReader dr;

                Usuario? usuario = new Usuario();
                dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                while (dr.Read())
                {
                    usuario.IdUsuario = (Int32)(dr["IdUsuario"]);
                    usuario.Nome = (string)(dr["Nome"]);
                    usuario.Telefone = (string)(dr["Telefone"]);
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
                MySqlCommand cmd = new MySqlCommand("SELECT IdUsuario, EmailUsuario, SenhaUsuario FROM tbUsuario WHERE EmailUsuario=@Email AND SenhaUsuario=@Senha", connection);
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
                connection.Close();
            }
        }
    }
}