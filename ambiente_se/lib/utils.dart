import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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


    

Future<http.Response> makeHttpRequest(String url, {String method = 'GET', dynamic body}) async {
  const String token = "Bearer "+  "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJyb290IiwiY2FyZ28iOiJBZG1pbiIsImV4cCI6MTcyNzYxNDAwOH0.jJE5_3Kd39pWu3N7Jcb0RzrSDjpui5H2f_ZDe65ZxRI";
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': token,
  };
  http.Response response;

  switch (method.toUpperCase()) {
    case 'POST':
      response = await http.post(Uri.parse(url), headers: headers, body: body);
      break;
    case 'PUT':
      response = await http.put(Uri.parse(url), headers: headers, body: body);
      break;
    case 'DELETE':
      response = await http.delete(Uri.parse(url), headers: headers, body: body);
      break;
    case 'GET':
    default:
      response = await http.get(Uri.parse(url), headers: headers);
      break;
  }

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return response;
  } else {
    throw Exception('Failed to load data: ${response.statusCode}');
  }
}