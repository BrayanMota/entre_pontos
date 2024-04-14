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
      return 'E-mail inválido';
    }
    return null;
  }
}
