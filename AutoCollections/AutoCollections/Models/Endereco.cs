using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Endereco
    {
        [Display(Description = "CEP")]
        public string CEP { get; set; }

        [Display(Description = "Estado")]
        public string Estado { get; set; }

        [Display(Description = "Cidade")]
        public string Cidade { get; set; }

        [Display(Description = "Bairro")]
        public string Bairro { get; set; }

        [Display(Description = "Rua")]
        public string Rua { get; set; }

        [Display(Description = "Número")]
        public int Numero { get; set; }

        [Display(Description = "Complemento")]
        public string Complemento { get; set; }
    }
}
