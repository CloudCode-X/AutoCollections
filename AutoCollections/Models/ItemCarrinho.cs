namespace AutoCollections.Models
{
    public class ItemCarrinho
    {
        public int IdCarrinho { get; set; }

        public int IdProduto { get; set; }

        public int QuantidadeProduto { get; set; }

        public decimal PrecoUnitario { get; set; }

        public decimal SubTotal { get; set; }
    }
}

