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
        
        [Display(Description = "Quantidade do produto em estoque")]
        public int QuantidadeEstoque { get; set; }

        [Display(Description = "Quantidade mínima do produto no estoque")]
        public string QuantidadeMinima { get; set; }

        [Display(Description = "Descrição do produto")]
        public string Descricao { get; set; }

        [Display(Description = "Id da Marca")]
        public int IdMarca { get; set; }

        [Display(Description = "Id da Categoria")]
        public int IdCategoria { get; set; }

        [Display(Description = "Cor do Produto")]
        public string CorProduto { get; set; }

        [Display(Description = "Nome da Categoria")]
        public int NomeCategoria { get; set; }

        [Display(Description = "Nome da Marca")]
        public int NomeMarca { get; set; }

        [Display(Description = "Logo da Marca")]
        public string LogoMarca { get; set; }

        [Display(Description = "Caminho da Imagem")]
        [Required]
        public string ImagemURL { get; set; }
    }
}
