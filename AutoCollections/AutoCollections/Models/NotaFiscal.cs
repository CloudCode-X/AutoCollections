using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class NotaFiscal
    {
        [Display(Description = "Id da Nota Fiscal")]
        public int IdNF { get; set; }

        [Display(Description = "Valor Total da Compra")]
        public decimal ValorTotal { get; set; }

        [Display(Description = "Data de emissão da nota fiscal")]
        public DateTime DataEmissao { get; set; }

        [Display(Description = "Número de série da nota fiscal")]
        public int NumeroSerie { get; set; }

        [Display(Description = "Id do Pedido")]
        public int IdPedido { get; set; }
    }
}
