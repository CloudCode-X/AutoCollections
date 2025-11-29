using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class ItemCarrinho
    {
        [Display(Description = "Id do Carrinho")]
        public int IdCarrinho { get; set; }

        [Display(Description = "Id do Produto")]
        public int IdProduto { get; set; }

        [Display(Description = "Quantidade do Item")]
        public int QuantidadeProduto { get; set; }

        [Display(Description = "Preço do Item")]
        public decimal PrecoUnitario { get; set; }

        [Display(Description = "SubTotal das quantidades de itens")]
        public decimal SubTotal { get; set; }
    }
}
