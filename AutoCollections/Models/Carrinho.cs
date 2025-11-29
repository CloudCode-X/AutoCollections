using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Carrinho
    {
        [Display(Description = "Código do Carrinho")]
        public int IdCarrinho { get; set; }

        [Display(Description = "Código do Cliente")]
        public int IdCliente { get; set; }

        [Display(Description = "Valor total do carrinho")]
        public decimal ValorTotal { get; set; }
    }
}
