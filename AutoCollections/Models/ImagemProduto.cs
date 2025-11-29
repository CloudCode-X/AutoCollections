using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class ImagemProduto
    {
        [Display(Description = "Id da Imagem")]
        public int ImagemId { get; set; }

        [Display(Description = "Id do Produto")]
        public int ProdutoId { get; set; }

        [Display(Description = "Caminho da Imagem")]
        public int CaminhoImagem { get; set; }
    }
}
