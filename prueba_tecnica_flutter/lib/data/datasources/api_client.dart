
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  Future<List<dynamic>> getItems() async {
    try {
      final response = await dio.get("https://picsum.photos/v2/list");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw "Error en la respuesta del servidor";
      }
    } catch (e) {
      throw Exception("Error en la API: $e");
    }
  }
}
