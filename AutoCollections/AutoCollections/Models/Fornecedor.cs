using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Fornecedor
    {
        [Display(Description = "Id do Fornecedor")]
        public int IdFornecedor { get; set; }

        [Display(Description = "Nome do Fornecedor")]
        public string NomeFornecedor { get; set; }

        [Display(Description = "CNPJ do Fornecedor")]
        public string CNPJ { get; set; }

        [Display(Description = "Telefone do Fornecedor")]
        public string TelefoneFornecedor { get; set; }

        [Display(Description = "Email do Fornecedor")]
        public string EmailFornecedor { get; set; }

        [Display(Description = "CEP do Fornecedor")]
        public string CEP { get; set; }
    }
}
