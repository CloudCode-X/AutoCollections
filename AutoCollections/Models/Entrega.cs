namespace AutoCollections.Models
{
    public class Entrega
    {
        public int IdEntrega { get; set; }

        public int IdPedido { get; set; }

        public string CodigoRastreamento { get; set; }

        public DateOnly DataEnvio { get; set; }

        public DateOnly DataEntrega { get; set; }

        public string StatusEntrega { get; set; }
    }
}