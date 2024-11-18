import 'package:http/http.dart' as http;
import 'package:prods_todos_app/models/product.dart';
import 'package:prods_todos_app/utils/consts.dart';

class ProdsJsonAPI {
  final url = Uri.parse('${Consts.mockUrl}products');
  final Map<String, String> headers = {'content-type': 'application/json'};

  //simple implementation, getting only 10 products
  Future<String> fetchProducts() async {
    final newurl = url.replace(queryParameters: {'limit': '10', 'page': '1'},);
    try {
      final res = await http.get(newurl, headers: headers);
      if (res.statusCode >= 200 && res.statusCode <= 299) {
        return res.body;
      } else {
        throw Exception('${res.statusCode} - ${res.reasonPhrase}');
      }
    } catch (e) {
      rethrow;
    }
  }

  
  Future<String> deleteProduct(Product pendingProduct) async {
    final newurl = Uri.parse('$url/${pendingProduct.id}');
    try {
      final res = await http.delete(newurl, headers: headers);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return res.body;
      } else {
        throw Exception('${res.statusCode} - ${res.reasonPhrase}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
