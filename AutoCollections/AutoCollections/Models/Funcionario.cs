using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Funcionario
    {
        [Display(Description = "Id do Funcionário")]
        public int IdFuncionario { get; set; }

        [Display(Description = "Nome do Funcionário")]
        [Required(ErrorMessage = "O nome completo é obrigatório")]
        public string NomeFuncionairo { get; set; }

        [Display(Description = "CPF do Funcionário")]
        [Required(ErrorMessage = "O CPF é obrigatório")]
        public string CPF { get; set; }

        [Display(Description = "Telefone do funcionário")]
        [Required(ErrorMessage = "O telefone é obrigatório")]
        public string TelefoneFuncionario { get; set; }

        [Display(Description = "Email do Funcionário")]
        [EmailAddress(ErrorMessage = " O Email não é valido.")]
        [RegularExpression(".+\\@.+\\..+", ErrorMessage = "Informe um e-mail válido")]
        public string EmailFuncionario { get; set; }

        [DataType(DataType.Password)]
        [Required(ErrorMessage = "A senha é obrigatória.")]
        [StringLength(10, MinimumLength = 8, ErrorMessage = "A senha deve ter entre 8 e 10 caracteres.")]
        public string SenhaFuncionario { get; set; }

        [Display(Description = "Cargo do Funcionário")]
        public string Cargo { get; set; }

        [Display(Description = "CEP do Funcionário")]
        [Required(ErrorMessage = "O CEP é obrigatório.")]
        public string CEP { get; set; }

        [Display(Description = "Data de Admissão do Funcionário")]
        public DateOnly DataAdmissao { get; set; }
    }
}
