class CustomValidators {
  static String? validarCampoObrigatorio(String? value) {
    if (value == null || value.isEmpty) {
      return 'Esse campo é obrigatório';
    }
    return null;
  }

  static String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Esse campo é obrigatório';
    }
    if (!value.contains('@')) {
      return 'E-mail inválido, verifique o @';
    }
    if (!value.contains('.') || value.split('.').last.length < 2) {
      return 'E-mail inválido, verifique o domínio';
    }
    return null;
  }

  static String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Esse campo é obrigatório';
    }
    if (value.length < 6) {
      return 'Senha deve ter no mínimo 6 caracteres';
    }
    return null;
  }
}
