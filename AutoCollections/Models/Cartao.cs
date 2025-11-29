using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Cartao
    {
        [Display(Description = "Código do Cartão cadastrado")]
        public int IdCartao { get; set; }

        [Display(Description = "Código do Cliente")]
        public int IdUsuario { get; set; }

        [Display(Description = "Bandeira do Cartão")]
        public string Bandeira { get; set; }

        [Display(Description = "Últimos quatro dígitos do número do cartão")]
        public string UltimosDigitos { get; set; }

        [Display(Description = "Nome do titular do cartão")]
        public string NomeTitular { get; set; }

        [Display(Description = "Validade do cartão em mês e ano")]
        public string ValidadeMes { get; set; }

        [Display(Description = "Token do Cartão")]
        public int TokenCartao { get; set; }

        [Display(Description = "Data de cadastro do cartão")]
        public DateTime DataCadastro { get; set; }
    }
}
