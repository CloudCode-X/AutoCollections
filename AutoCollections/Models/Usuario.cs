using System.ComponentModel.DataAnnotations;

namespace AutoCollections.Models
{
    public class Usuario
    {
        [Display(Description = "Código do Usuário")]
        public int IdUsuario { get; set; }

        [Display(Description = "CPF do usuário")]
        [Required(ErrorMessage = "O CPF é obrigatório.")]
        public string CPF { get; set; }

        [Display(Description = "Nome do Usuário")]
        [Required(ErrorMessage = "O nome completo é obrigatório.")]
        public string Nome { get; set; }

        [Display(Description = "Data de Nascimento do Usuário")]
        [Required(ErrorMessage = "A data é obrigatória.")]
        public DateOnly DataNascimento { get; set; }

        [Display(Description = "Telefone do Usuário")]
        [Required(ErrorMessage = "O telefone é obrigatório.")]
        public string Telefone { get; set; }

        [Display(Description = "Email do Usuário")]
        [EmailAddress(ErrorMessage = " O Email não é valido.")]
        [RegularExpression(".+\\@.+\\..+", ErrorMessage = "Informe um e-mail válido")]
        public string Email { get; set; }

        [Display(Description = "Senha do Usuário")]
        [DataType(DataType.Password)]
        [Required(ErrorMessage = "A senha é obrigatória.")]
        [StringLength(10, MinimumLength = 8, ErrorMessage = "A senha deve ter entre 8 e 10 caracteres.")]
        public string Senha { get; set; }

        [Display(Description = "Número de Endereço do Usuário")]
        [Required(ErrorMessage = "O número de endereço é obrigatório.")]
        public string NumeroEndereco { get; set; }

        [Display(Description = "Complemento do endereço do usuário")]
        public string ComplementoEndereco { get; set; }

        [Display(Description = "CEP do Usuário")]
        [Required(ErrorMessage = "O CEP é obrigatório.")]
        public string CEP { get; set; }
    }
}
