namespace AutoCollections.Models
{
    public class NotaFiscal
    {
        public int IdNF { get; set; }

        public decimal ValorTotal { get; set; }

        public DateTime DataEmissao { get; set; }

        public int NumeroSerie { get; set; }

        public int IdPedido { get; set; }
    }
}
