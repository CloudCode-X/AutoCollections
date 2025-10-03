namespace AutoCollections.Models
{
    public class Produto
    {
        public int IdProduto { get; set; }

        public int IdFornecedor { get; set; }

        public string NomeProduto { get; set; }

        public decimal PrecoUnitario { get; set; }

        public string Escala { get; set; }

        public decimal Peso { get; set; }

        public string Material { get; set; }

        public string TipoProduto { get; set; }

        public int QuantidadePecas { get; set; }

        public string Marca { get; set; }

        public string Categoria { get; set; }

        public int QuantidadeEstoque { get; set; }

        public int QuantidadeMinima { get; set; }

        public string Descricao { get; set; }
    }
}
