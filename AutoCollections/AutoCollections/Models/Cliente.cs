using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Cliente
    {
        [Display(Description = "Código do Cliente")]
        public int IdCliente { get; set; }

        [Display(Description = "CPF do cliente")]
        [Required(ErrorMessage = "O CPF é obrigatório.")]
        public string CPF_Cliente { get; set; }

        [Display(Description = "Nome do cliente")]
        [Required(ErrorMessage = "O nome completo é obrigatório.")]
        public string Nome_Cliente { get; set; }

        [Display(Description = "Senha do cliente")]
        [DataType(DataType.Password)]
        [Required(ErrorMessage = "A senha é obrigatória.")]
        [StringLength(10, MinimumLength = 8, ErrorMessage = "A senha deve ter entre 8 e 10 caracteres.")]
        public string Senha_Cliente { get; set; }

        [Display(Description = "Data de Nascimento do cliente")]
        [Required(ErrorMessage = "A data é obrigatória.")]
        public DateOnly DataNascimento { get; set; }

        [Display(Description = "Telefone do Cliente")]
        [Required(ErrorMessage = "O telefone é obrigatório.")]
        public int Telefone_Cliente { get; set; }

        [Display(Description = "Email do Cliente")]
        [EmailAddress(ErrorMessage = " O Email não é valido.")]
        [RegularExpression(".+\\@.+\\..+", ErrorMessage = "Informe um e-mail válido")]
        public string Email_Cliente { get; set; }

        [Display(Description = "CEP do Cliente")]
        [Required(ErrorMessage = "O CEP é obrigatório.")]
        public string CEP_Cliente { get; set; }
    }
}
