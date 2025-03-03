import 'dart:io';

import 'package:ambiente_se/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String backendUrl = 'localhost:8080';

class AppColors {
  static const Color blue = Color(0xFF0077C8);
  static const Color darkBlue = Color(0xFF005A9C);
  static const Color green = Color(0xFF0C9C6F);
  static const Color red = Color(0xFFDF2935);
  static const Color socialPillar = Color.fromRGBO(240, 135, 11, 1.0);
  static const Color environmentalPillar = Color.fromRGBO(106, 192, 74, 1.0);
  static const Color governmentPillar = Color.fromRGBO(0, 113, 191, 1.0);
  static const Color grey = Color(0xFF838B91);
  static const Color offWhite = Color.fromRGBO(207, 207, 207, 1);
  static const Color offBlack = Color(0xFF202020);
  static const Color ice = Color(0xFFD5E2E7);
}


bool isValidCNPJ(String cnpj) {
  cnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
  if (cnpj.length != 14) {
    return false;
  }

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

  int calculateDigit(String base, List<int> weights) {
    int sum = 0;
    for (int i = 0; i < base.length; i++) {
      sum += int.parse(base[i]) * weights[i];
    }
    int remainder = sum % 11;
    return remainder < 2 ? 0 : 11 - remainder;
  }

  const weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  const weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  String baseCNPJ = cnpj.substring(0, 12);
  int firstDigit = calculateDigit(baseCNPJ, weights1);

  baseCNPJ += firstDigit.toString();
  int secondDigit = calculateDigit(baseCNPJ, weights2);

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
  cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
  if (cpf.length != 11) {
    return false;
  }

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

  int calculateDigit(String base, List<int> weights) {
    int sum = 0;
    for (int i = 0; i < base.length; i++) {
      sum += int.parse(base[i]) * weights[i];
    }
    int remainder = sum % 11;
    return remainder < 2 ? 0 : 11 - remainder;
  }

  const weights1 = [10, 9, 8, 7, 6, 5, 4, 3, 2];
  const weights2 = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2];

  String baseCPF = cpf.substring(0, 9);
  int firstDigit = calculateDigit(baseCPF, weights1);

  baseCPF += firstDigit.toString();
  int secondDigit = calculateDigit(baseCPF, weights2);

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
    if (date.isEmpty) return '';
    final parts = date.split('-');
    if (parts.length != 3) return date; 
    return '${parts[2]}/${parts[1]}/${parts[0]}';
}

  String parseDateBackFront(data) {
    if (data == null) return '';
    final parts = data.split('/');
    if (parts.length != 3) return data;
    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }

bool isValidDate(String date) {
  final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  if (!dateRegex.hasMatch(date)) {
    return false;
  }

  final parts = date.split('/');
  final day = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  final year = int.tryParse(parts[2]);

  if (day == null || month == null || year == null) {
    return false;
  }

  try {
    final parsedDate = DateTime(year, month, day);
    final today = DateTime.now();

    if (parsedDate.isAfter(today)) {
      return false;
    }
    if (parsedDate.day != day || parsedDate.month != month) {
      return false;
    }

    return true;
  } catch (e) {
    return false;
  }
}



Future<http.Response> makeHttpRequest(BuildContext context, String endpoint, {String method = 'GET', dynamic body, dynamic parameters}) async {
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
    } else if (response.statusCode == 401 && url.path != '/api/login') {
      await secureStorage.delete(key: 'auth_token');
      
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro'),
            content: const Text('Sessão expirada ou token inválido, faça login novamente.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      // Navigate to login page after dialog is closed
      await Navigator.of(context)
        .pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginPage()
          ), (Route<dynamic> route) => false
        );
        
      throw Exception('Unauthorized');
    }else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error making HTTP request: $e');
    rethrow;
  }
}

Future<void> downloadReport(BuildContext context, dynamic company) async {
  try {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Download iniciado!'), duration: Duration(seconds: 2)),
    );

    final response = await makeHttpRequest(context, 'api/pdf/${company['id'].toString()}');

    if (response.statusCode == 200) {
      if (Platform.isAndroid) {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
        }
      }

      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/report_${company['tradeName'] ?? company['companyName']}.pdf';

      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Download concluído!'), duration: Duration(seconds: 2)),
      );

      await OpenFile.open(filePath);
    } else {
      throw Exception('Failed to download PDF');
    }
  } catch (e) {
    print('Error downloading report: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Erro ao baixar o relatório'), duration: Duration(seconds: 2)),
    );
  }
}
