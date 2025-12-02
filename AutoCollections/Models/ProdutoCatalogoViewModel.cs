namespace AutoCollections.Models
{
    public class ProdutoCatalogoViewModel
    {
        public string Categoria { get; set; }
        public List<ItemCatalogoViewModel> Produtos { get; set; }
    }

    public class ItemCatalogoViewModel
    {
        public int IdProduto { get; set; }
        public string NomeProduto { get; set; }
        public string ImagemURL { get; set; }
    }
}
