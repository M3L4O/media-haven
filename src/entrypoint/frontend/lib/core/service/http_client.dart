import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart' show MediaType;

import '../../app/dashboard/data/models/file_params.dart';

abstract class IHttpClient {
  Future<Response> get(String url, String token);
  Future<Response> post(String url, Map<String, dynamic> body);
  Future<StreamedResponse> postFile(FileParams file, String token);
  Future<Response> put(String url, Map<String, dynamic> body);
  Future<Response> delete(String url, String token);
  Map<String, String> getHeaders();
  void logResponse(Response response, [Object? body]);
}

class HttpClient implements IHttpClient {
  final client = Client();
  final baseUrl = 'http://0.0.0.0:8000/';

  @override
  void logResponse(Response response, [Object? body]) {
    log(
      "---- [LOG] REQUEST ---- \n"
      "URL: ${response.request?.url}\n"
      "METHOD: ${response.request?.method}\n"
      "REQUEST: $body\n"
      "---- [LOG] RESPONSE ----\n"
      "STATUS CODE: ${response.statusCode}\n"
      "DATA: ${response.body}",
    );
  }

  @override
  Future<Response> delete(
    String url,
    String token,
  ) {
    return client.delete(
      Uri.parse(baseUrl + url),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "JWT $token",
      },
    );
  }

  @override
  Future<Response> get(
    String url,
    String token,
  ) {
    return client.get(
      Uri.parse(baseUrl + url),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "JWT $token",
      },
    );
  }

  @override
  Future<Response> post(
    String url,
    Map<String, dynamic> body,
  ) async {
    return client.post(
      Uri.parse(baseUrl + url),
      headers: getHeaders(),
      body: jsonEncode(body),
    );
  }

  @override
  Future<StreamedResponse> postFile(
    FileParams file,
    String token,
  ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        'http://0.0.0.0:8000/file/${file.type}s/upload/',
      ),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        file.bytes!,
        filename: file.name,
        contentType: MediaType(
          file.type!,
          file.fileExtension!,
        ),
      ),
    );

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      "Authorization": "JWT $token",
    });

    var response = await request.send();

    log(response.request.toString());
    log(response.headers.toString());
    log(response.statusCode.toString());

    return response;
  }

  @override
  Future<Response> put(
    String url,
    Map<String, dynamic> body,
  ) {
    return client.put(
      Uri.parse(baseUrl + url),
      body: body,
    );
  }

  @override
  Map<String, String> getHeaders() {
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
  }
}
