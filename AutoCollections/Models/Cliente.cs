namespace AutoCollections.Models
{
    public class Cliente
    {
        public int IdCliente { get; set; }

        public string CPFCliente { get; set; }

        public string NomeCliente { get; set; }

        public string SenhaCliente {  get; set; }

        public DateOnly DataNascimento { get; set; }

        public string TelefoneCliente { get; set; }

        public string EmailCliente { get; set; }
        public string CEPCliente { get; set; }

    }
}
