using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class UsuNivel
    {
        [Display(Description = "Id do Usuario")]
        public int IdUsuario { get; set; }

        [Display(Description = "Nome do Nivel")]
        public int IdNivel { get; set; }
    }
}
