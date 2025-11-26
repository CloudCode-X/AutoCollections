using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Endereco
    {
        [Display(Description = "Logradouro")]
        public string Logradouro { get; set; }

        [Display(Description = "CEP")]
        public string CEP { get; set; }

        [Display(Description = "Estado")]
        public string IdUF { get; set; }

        [Display(Description = "Cidade")]
        public string IdCidade { get; set; }

        [Display(Description = "Bairro")]
        public string IdBairro { get; set; }
    }
}
