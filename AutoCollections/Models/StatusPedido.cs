using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class StatusPedido
    {
        [Display(Description = "Id do Status")]
        public int IdStatus { get; set; }

        [Display(Description = "Nome o Status")]
        public int NomeStatus { get; set; }
    }
}
