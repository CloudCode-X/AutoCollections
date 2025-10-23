using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Produto
    {
        [Display(Description = "Id do Produto")]
        public int IdProduto { get; set; }

        [Display(Description = "Id do Fornecedor")]
        public int IdFornecedor { get; set; }

        [Display(Description = "Nome do Produto")]
        public string NomeProduto { get; set; }

        [Display(Description = "Preço Unitário do produto")]
        public decimal PrecoUnitario { get; set; }

        [Display(Description = "Escala do produto")]
        public string Escala { get; set; }

        [Display(Description = "Peso do produto")]
        public decimal Peso { get; set; }

        [Display(Description = "Material do produto")]
        public string Material { get; set; }

        [Display(Description = "Tipo do produto")]
        public string TipoProduto { get; set; }

        [Display(Description = "Quantidade de peças do produto")]
        public int QuantidadePecas { get; set; }

        [Display(Description = "Marca do produto")]
        public string Marca { get; set; }

        [Display(Description = "Imagem do produto")]
        public string ImgProduto { get; set; }


        [Display(Description = "Categoria do produto")]
        public string Categoria { get; set; }

        [Display(Description = "Quantidade do produto em estoque")]
        public int QuantidadeEstoque { get; set; }

        [Display(Description = "Quantidade mínima do produto em estoque")]
        public int QuantidadeMinima { get; set; }

        [Display(Description = "Descrição do produto")]
        public string Descricao { get; set; }
    }
}
