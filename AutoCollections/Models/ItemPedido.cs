namespace AutoCollections.Models
{
    public class ItemPedido
    {
        public int IdPedido { get; set; }

        public int IdProduto { get; set; }

        public int QuantidadeProduto { get; set; }

        public decimal PrecoUnitario { get; set; }

        public decimal SubTotal { get; set; }
    }
}
