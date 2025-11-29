using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Pagamento
    {
        [Display(Description = "Id do Pagamento")]
        public int IdPagamento { get; set; }

        [Display(Description = "Id do Pedido")]
        public int IdPedido { get; set; }

        [Display(Description = "Método de Pagamento")]
        public string MetodoPagamento { get; set; }

        [Display(Description = "Valor de Pagamento")]
        public decimal ValorPagamento { get; set; }

        [Display(Description = "Status de Pagamento")]
        public string StatusPagamento { get; set; }

        [Display(Description = "Código da Transação")]
        public string CodigoTransacao { get; set; }

        [Display(Description = "Data de Criação do pagamento")]
        public DateTime DataCriacao { get; set; }

        [Display(Description = "Data de Confirmação do pagamento")]
        public DateTime DataConfirmacao { get; set; }
    }
}
