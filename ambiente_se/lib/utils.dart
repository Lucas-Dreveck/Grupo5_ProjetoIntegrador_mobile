import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const String backendUrl = 'localhost:8080'; // Substitua pelo endereço IP do seu servidor


class AppColors {
  static const Color blue = Color(0xFF0077C8);
  static const Color darkBlue = Color(0xFF005A9C);
  static const Color green = Color(0xFF0C9C6F);
  static const Color logoGreen = Color.fromRGBO(118, 192, 77, 1);
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

String formatCnpj(String cnpj) {
  cnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
  if (cnpj.length > 2) {
    cnpj = '${cnpj.substring(0, 2)}.${cnpj.substring(2)}';
  }
  if (cnpj.length > 6) {
    cnpj = '${cnpj.substring(0, 6)}.${cnpj.substring(6)}';
  }
  if (cnpj.length > 10) {
    cnpj = '${cnpj.substring(0, 10)}/${cnpj.substring(10)}';
  }
  if (cnpj.length > 15) {
    cnpj = '${cnpj.substring(0, 15)}-${cnpj.substring(15)}';
  }
  return cnpj;
}

bool isValidCPF(String cpf) {
  // Remove qualquer caractere que não seja dígito
  cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
  // Verifica se o CPF tem 11 dígitos
  if (cpf.length != 11) {
    return false;
  }

  // Lista de CPFs inválidos conhecidos
  const invalidCPFs = [
    '00000000000',
    '11111111111',
    '22222222222',
    '33333333333',
    '44444444444',
    '55555555555',
    '66666666666',
    '77777777777',
    '88888888888',
    '99999999999'
  ];

  if (invalidCPFs.contains(cpf)) {
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
  const weights1 = [10, 9, 8, 7, 6, 5, 4, 3, 2];
  const weights2 = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2];

  // Cálculo do primeiro dígito verificador
  String baseCPF = cpf.substring(0, 9);
  int firstDigit = calculateDigit(baseCPF, weights1);

  // Cálculo do segundo dígito verificador
  baseCPF += firstDigit.toString();
  int secondDigit = calculateDigit(baseCPF, weights2);

  // Compara os dígitos calculados com os dígitos fornecidos
  return cpf.endsWith('$firstDigit$secondDigit');
}

String formatCpf(String cpf) {
  cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
  if (cpf.length > 3) {
    cpf = '${cpf.substring(0, 3)}.${cpf.substring(3)}';
  }
  if (cpf.length > 7) {
    cpf = '${cpf.substring(0, 7)}.${cpf.substring(7)}';
  }
  if (cpf.length > 11) {
    cpf = '${cpf.substring(0, 11)}-${cpf.substring(11)}';
  }
  return cpf;
}

String formatPhone(String phone) {
    phone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (phone.isNotEmpty) {
      phone = '+${phone.substring(0, 2)} (${phone.substring(2)}';
    }
    if (phone.length > 6) {
      phone = '${phone.substring(0, 6)}) ${phone.substring(6)}';
    }
    if (phone.length > 12) {
      phone = '${phone.substring(0, 11)}-${phone.substring(11)}';
    }
    return phone;
  }

String formatCep(String cep) {
    cep = cep.replaceAll(RegExp(r'[^0-9]'), '');
    if (cep.length > 5) {
      cep = '${cep.substring(0, 5)}-${cep.substring(5)}';
    }
    return cep;
  }

String formatDate(String date) {
    if (date.isEmpty) {
      return '';
    }
    List<String> parts = date.split('/');
    if (parts.length != 3) {
      return '';
    }
    String day = parts[0].padLeft(2, '0');
    String month = parts[1].padLeft(2, '0');
    String year = parts[2];
    return '$year-$month-$day';
  }

Future<http.Response> makeHttpRequest(String endpoint, {String method = 'GET', dynamic body, dynamic parameters}) async {
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  Uri url;
  if (parameters != null) {
    url = Uri.http(backendUrl, endpoint, parameters);
  } else {
    url = Uri.http(backendUrl, endpoint);
  }
  String? token = await secureStorage.read(key: 'auth_token');

  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  http.Response response;

  try {
    switch (method.toUpperCase()) {
      case 'POST':
        response = await http.post(url, headers: headers, body: body);
        break;
      case 'PUT':
        response = await http.put(url, headers: headers, body: body);
        break;
      case 'DELETE':
        response = await http.delete(url, headers: headers, body: body);
        break;
      case 'GET':
      default:
        response = await http.get(url, headers: headers);
        break;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error making HTTP request: $e');
    rethrow;
  }
}
