using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Estado
    {
        [Display(Description = "Id do Estado")]
        public int UFId { get; set; }

        [Display(Description = "Nome do Estado")]
        public int UF { get; set; }
    }
}
