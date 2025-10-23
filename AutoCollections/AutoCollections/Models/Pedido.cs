using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Pedido
    {
        [Display(Description = "Id do Pedido")]
        public int IdPedido { get; set; }

        [Display(Description = "Data do Pedido")]
        public DateTime DataPedido { get; set; }

        [Display(Description = "Valor total do pedido")]
        public decimal ValorTotal { get; set; }

        [Display(Description = "Id do Cliente")]
        public int IdCliente { get; set; }

        [Display(Description = "Status do Pedido")]
        public string PedidoStatus { get; set; }
    }
}
