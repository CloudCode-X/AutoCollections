using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class NivelAcesso
    {
        [Display(Description = "Id do Nível")]
        public int IdNivel { get; set; }

        [Display(Description = "Nome do Nível")]
        public int NomeNivel { get; set; }
    }
}
