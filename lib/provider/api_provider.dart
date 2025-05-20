import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_listing_application/domain/models/stock_list_model.dart';

class ApiProvider {
  final String _baseUrl = 'http://coding-assignment.bombayrunning.com/data.json';

  Future<List<StockListModel>> fetchList() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List decoded = json.decode(response.body);
      return decoded.map((json) => StockListModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load stocks list');
    }
  }
}