using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Entrega
    {
        [Display(Description = "Id da Entrega")]
        public int IdEntrega { get; set; }

        [Display(Description = "Id do Pedido")]
        public int IdPedido { get; set; }

        [Display(Description = "Código de Rastreamento da Entrega")]
        public string CodigoRastreamento { get; set; }

        [Display(Description = "Data de Envio da Entrega")]
        public DateOnly DataEnvio { get; set; }

        [Display(Description = "CEP")]
        public DateOnly DataEntrega { get; set; }

        [Display(Description = "Status da Entrega")]
        public string StatusEntrega { get; set; }
    }
}
