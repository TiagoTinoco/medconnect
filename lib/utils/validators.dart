String? isNotNullValidator(String? string) {
  if (string == null || string.isEmpty) {
    return 'Este campo não pode ser enviado vazio.';
  }

  return null;
}

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Digite seu e-mail!';
  }

  if (!email.contains('@')) {
    return 'Digite um e-mail válido';
  }

  if (!email.contains('.com')) {
    return 'Digite um e-mail válido';
  }

  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Digite sua senha';
  }

  if (password.length < 7) {
    return 'Digite uma senha com pelo menos 7 caracteres.';
  }

  return null;
}

String? nameValidator(String? fullname) {
  if (fullname == null || fullname.isEmpty) {
    return 'Digite um nome!';
  }

  final name = fullname.split(' ');

  if (name.length == 1) {
    return 'Digite seu nome Completo!';
  }

  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Digite um número de telefone!';
  }
  String pattern = r'^\(\d{2}\) \d{4,5}-\d{4}$';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(phone)) {
    return 'Número de telefone inválido';
  }

  return null;
}
