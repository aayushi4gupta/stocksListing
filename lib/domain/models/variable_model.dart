class Variable {
  final String type;
  final List<dynamic>? values;
  final String? studyType;
  final String? parameterName;
  final int? minValue;
  final int? maxValue;
  final int? defaultValue;

  Variable({
    required this.type,
    this.values,
    this.studyType,
    this.parameterName,
    this.minValue,
    this.maxValue,
    this.defaultValue,
  });

  factory Variable.fromJson(Map<String, dynamic> json) {
    return Variable(
      type: json['type'],
      values: json['values'] != null
          ? List<dynamic>.from(json['values'])
          : null,
      studyType: json['study_type'],
      parameterName: json['parameter_name'],
      minValue: json['min_value'],
      maxValue: json['max_value'],
      defaultValue: json['default_value'],
    );
  }
}
