namespace AutoCollections.Models
{
    public class Pagamento
    {
        public int IdPagamento { get; set; }

        public int IdPedido { get; set; }

        public string MetodoPagamento { get; set; }

        public decimal ValorPagamento { get; set; }

        public string StatusPagamento { get; set; }

        public string CodigoTransacao { get; set; }

        public DateTime DataCriacao { get; set; }

        public DateTime DataConfirmacao { get; set; }
    }
}
