import 'package:http/http.dart';

abstract class IHttpClient {
  Future<Response> get(String url);
  Future<Response> post(String url, Map<String, dynamic> body);
  Future<Response> put(String url, Map<String, dynamic> body);
  Future<Response> delete(String url);

  Map<String, String> getHeaders();
}

class HttpClient implements IHttpClient {
  final client = Client();

  @override
  Future<Response> delete(
    String url,
  ) {
    return client.delete(
      Uri.parse(url),
    );
  }

  @override
  Future<Response> get(
    String url,
  ) {
    return client.get(
      Uri.parse(url),
    );
  }

  @override
  Future<Response> post(
    String url,
    Map<String, dynamic> body,
  ) async {
    return client.post(
      Uri.parse(url),
      body: body,
    );
  }

  @override
  Future<Response> put(
    String url,
    Map<String, dynamic> body,
  ) {
    return client.put(
      Uri.parse(url),
      body: body,
    );
  }

  @override
  Map<String, String> getHeaders() {
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
      // "KeyAPI": "${Env.to?.keyAPI}",
    };
  }
}
