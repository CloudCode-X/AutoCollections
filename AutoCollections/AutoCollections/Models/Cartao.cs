using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Cartao
    {
        [Display(Description = "Código do Cartão cadastrado")]
        public int IdCartao { get; set; }

        [Display(Description = "Código do Cliente")]
        public int IdCliente { get; set; }

        [Display(Description = "Bandeira do Cartão")]
        public string Bandeira { get; set; }

        [Display(Description = "Últimos quatro dígitos do número do cartão")]
        public string UltimosDigitos { get; set; }

        [Display(Description = "Nome do titular do cartão")]
        public string NomeTitular { get; set; }

        [Display(Description = "Validade do cartão em mês e ano")]
        public string Validade { get; set; }

        [Display(Description = "Data de cadastro do cartão")]
        public DateTime DataCadastro { get; set; }

        [Display(Description = "Data de alguma atualização no cartão (vencimento ou exclusão)")]
        public DateTime DataAtualizacao { get; set; }
    }
}
