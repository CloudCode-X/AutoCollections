namespace AutoCollections.Models
{
    public class ProdutoViewModel
    {
        public int IdProduto { get; set; }

        public string NomeProduto { get; set; }

        public List<string> ImagemURL { get; set; } = new List<string>();

        public int QuantidadeEstoque { get; set; }

        public string CorProduto { get; set; }

        public string Escala { get; set; }

        public decimal PrecoUnitario { get; set; }

        public string Descricao { get; set; }
    }
}
