import 'dart:async';
import 'dart:convert';

import "package:http/http.dart" show Client, Response;

abstract class ClientService {
  Future<String> post(Uri url, {Map<String, String>? headers, Object? body});
  Object handleErrorReturn(Object e);
  void dispose();
}

class HttpClient implements ClientService {
  final Client client = Client();

  @override
  Future<String> post(Uri url,
      {Map<String, String>? headers, Object? body}) async {
    try {
      Response response = await client
          .post(
            url,
            headers: headers,
            body: body,
          )
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw handleErrorReturn(json.decode(response.body));
      } else {
        throw "Erro na conexão da API (Status: ${response.statusCode})";
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw "Falha ao receber resposta em tempo hábil!";
      }
      rethrow;
    }
  }

  @override
  Object handleErrorReturn(Object e) {
    if (e is String) {
      return e;
    } else if (e is Map<String, dynamic>) {
      if (e["message"] is String) {
        throw e["message"];
      } else if (e["message"] is List) {
        List errors = e["message"];
        String error = "";
        for (var element in errors) {
          Map<String, dynamic> errorMap = element["constraints"];
          errorMap.forEach((key, value) {
            error += value + "\n";
          });
        }
        throw error;
      } else {
        throw "Internal error";
      }
    }
    return e;
  }

  @override
  void dispose() {
    client.close();
  }
}
