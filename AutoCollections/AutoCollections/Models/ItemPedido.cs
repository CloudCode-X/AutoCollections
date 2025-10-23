using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class ItemPedido
    {
        [Display(Description = "Id do Pedido")]
        public int IdPedido { get; set; }

        [Display(Description = "Id do Produto")]
        public int IdProduto { get; set; }

        [Display(Description = "Quantidade de Item")]
        public int QuantidadeProduto { get; set; }

        [Display(Description = "Preço Unitário do Item")]
        public decimal PrecoUnitario { get; set; }

        [Display(Description = "SubtTotal da quantidade de Itens")]
        public decimal SubTotal { get; set; }
    }
}
