namespace AutoCollections.Models
{
    public class Cartao
    {
        public int IdCartao { get; set; }

        public int IdCliente { get; set; }

        public string Bandeira {  get; set; }

        public string UltimosDigitos { get; set; }

        public string NomeTitular { get; set; }

        public string Validade  { get; set; }

        public DateTime DataCadastro { get; set; }

        public DateTime DataAtualizacao { get; set; }
    }
}
