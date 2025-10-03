namespace AutoCollections.Models
{
    public class Pedido
    {
        public int IdPedido { get; set; }

        public DateTime DataPedido { get; set; }

        public decimal ValorTotal { get; set; }

        public int IdCliente { get; set; }

        public string PedidoStatus  { get; set; }
    }
}
