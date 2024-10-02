import 'package:flutter/material.dart';

class AppColors {
  static const Color blue = Color(0xFF0077C8);
  static const Color green = Color(0xFF0C9C6F);
  static const Color red = Color(0xFFDF2935);
  static const Color grey = Color(0xFF838B91);
  static const Color offWhite = Color.fromRGBO(207, 207, 207, 1);
  static const Color offBlack = Color(0xFF202020);
  static const Color ice = Color(0xFFD5E2E7);
}


bool isValidCNPJ(String cnpj) {
  // Remove qualquer caractere que não seja dígito
  cnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
  // Verifica se o CNPJ tem 14 dígitos
  if (cnpj.length != 14) {
    return false;
  }

  // Lista de CNPJs inválidos conhecidos
  const invalidCNPJs = [
    '00000000000000',
    '11111111111111',
    '22222222222222',
    '33333333333333',
    '44444444444444',
    '55555555555555',
    '66666666666666',
    '77777777777777',
    '88888888888888',
    '99999999999999'
  ];

  if (invalidCNPJs.contains(cnpj)) {
    return false;
  }

  // Função auxiliar para calcular o dígito verificador
  int calculateDigit(String base, List<int> weights) {
    int sum = 0;
    for (int i = 0; i < base.length; i++) {
      sum += int.parse(base[i]) * weights[i];
    }
    int remainder = sum % 11;
    return remainder < 2 ? 0 : 11 - remainder;
  }

  // Pesos para o cálculo dos dígitos verificadores
  const weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  const weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  // Cálculo do primeiro dígito verificador
  String baseCNPJ = cnpj.substring(0, 12);
  int firstDigit = calculateDigit(baseCNPJ, weights1);

  // Cálculo do segundo dígito verificador
  baseCNPJ += firstDigit.toString();
  int secondDigit = calculateDigit(baseCNPJ, weights2);

  // Compara os dígitos calculados com os dígitos fornecidos
  return cnpj.endsWith('$firstDigit$secondDigit');
}