import 'package:stock_listing_application/domain/models/criteria_model.dart';

class StockListModel {
  final int id;
  final String name;
  final String tag;
  final String color;
  final List<Criteria> criteria;

  StockListModel({
    required this.id,
    required this.name,
    required this.tag,
    required this.color,
    required this.criteria,
  });

  factory StockListModel.fromJson(Map<String, dynamic> json) {
    return StockListModel(
      id: json['id'],
      name: json['name'],
      tag: json['tag'],
      color: json['color'],
      criteria: (json['criteria'] as List)
          .map((e) => Criteria.fromJson(e))
          .toList(),
    );
  }
}