using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Bairro
    {
        [Display(Description = "Id do Bairro")]
        public int BairroId { get; set; }

        [Display(Description = "Nome do Bairro")]
        public int NomeBairro { get; set; }

        [Display(Description = "Id da Cidade")]
        public int IdCidade { get; set; }
    }
}
