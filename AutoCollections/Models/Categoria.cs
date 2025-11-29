using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Categoria
    {
        [Display(Description = "Código da Categoria")]
        public int IdCategoria { get; set; }

        [Display(Description = "Nome da Categoria")]
        public int NomeCategoria { get; set; }
    }
}
