using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Cidade
    {
        [Display(Description = "Id da Cidade")]
        public int CidadeId { get; set; }

        [Display(Description = "Nome da Cidade")]
        public int NomeCidade { get; set; }

        [Display(Description = "Id do Estado")]
        public int IdUF { get; set; }

    }
}
