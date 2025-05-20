import 'package:stock_listing_application/domain/models/variable_model.dart';

class Criteria {
  final String type;
  final String text;
  final Map<String, Variable>? variable;

  Criteria({
    required this.type,
    required this.text,
    this.variable,
  });

  factory Criteria.fromJson(Map<String, dynamic> json) {
    return Criteria(
      type: json['type'],
      text: json['text'],
      variable: json['variable'] != null
          ? (json['variable'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(key, Variable.fromJson(value)),
            )
          : null,
    );
  }
}