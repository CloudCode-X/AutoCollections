namespace AutoCollections.Models
{
    public class ProdutoViewModel
    {
        public string NomeProduto { get; set; }

        public List<string> CaminhoImagem { get; set; } = new List<string>();

        public int QuantidadeEstoque { get; set; }

        public string CorProduto { get; set; }

        public string Escala { get; set; }

        public decimal PrecoUnitario { get; set; }

        public string Descricao { get; set; }
    }
}
