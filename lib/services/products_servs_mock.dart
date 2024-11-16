import 'package:http/http.dart' as http;
import 'package:prods_todos_app/utils/consts.dart';

class ProductsServsMock {
  final url = Uri.parse('${Consts.mockUrl}products');
  final Map<String, String> headers = {'content-type': 'application/json'};

  //simple implementation
  getTenProducts() async {
    url.replace(queryParameters: {'limit': '10'});

    try {
      final res = await http.get(url, headers: headers);
      if (res.statusCode >= 200 && res.statusCode <= 299) {
        return res.body;
      } else {
        throw Exception('${res.statusCode} - ${res.reasonPhrase}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
