using System.ComponentModel.DataAnnotations;
namespace AutoCollections.Models
{
    public class Marcas
    {
        [Display(Description = "Código da Marca")]
        public int IdMarca { get; set; }

        [Display(Description = "Nome da Marca")]
        public int NomeMarca { get; set; }

        [Display(Description = "Logo da Marca")]
        public int LogoMarca { get; set; }
    }
}
