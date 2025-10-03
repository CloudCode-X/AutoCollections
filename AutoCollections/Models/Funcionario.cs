namespace AutoCollections.Models
{
    public class Funcionario
    {
        public int IdFuncionario { get; set; }

        public string NomeFuncionairo { get; set; }

        public string CPF { get; set; }

        public string TelefoneFuncionario { get; set; }

        public string EmailFuncionario { get; set; }

        public string Cargo { get; set; }

        public string CEP { get; set; }

        public DateOnly DataAdmissao { get; set; }
    }
}