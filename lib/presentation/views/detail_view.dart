import 'package:flutter/material.dart';
import 'package:stock_listing_application/domain/models/criteria_model.dart';
import 'package:stock_listing_application/domain/models/stock_list_model.dart';
import 'package:stock_listing_application/domain/models/variable_model.dart';
import 'package:stock_listing_application/presentation/utils/utility.dart';

class DetailView extends StatelessWidget {
  final StockListModel item;

  const DetailView({super.key, required this.item});



  @override
  Widget build(BuildContext context) {
    
    final headerColor = Utility.getColorFromString(item.color);

    return Scaffold(
      backgroundColor: const Color(0xFF021015), // dark background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.lightBlue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    item.tag,
                    style: TextStyle(fontSize: 16, color: headerColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Criteria
Expanded(
              child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: item.criteria.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (_, index) {
                final value = item.criteria[index];
                return RichText(
                  text: buildRichCriteria(value.text, value.variable??{}),
                );
              },
            ),
            ),

          ],
        ),
      ),
    );
  }
  // Format variable text
 TextSpan buildRichCriteria(String text, Map<String, Variable> variableMap) {
  List<TextSpan> spans = [];
  RegExp regex = RegExp(r'\$[0-9]+');
  int lastMatchEnd = 0;

  for (final match in regex.allMatches(text)) {
    if (match.start > lastMatchEnd) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
    }

    String key = match.group(0)!;
    dynamic variable = variableMap[key];

    spans.add(
      TextSpan(
        text: '(${getVariableDisplayValue(variable)})',
        style: const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
    lastMatchEnd = match.end;
  }

  if (lastMatchEnd < text.length) {
    spans.add(TextSpan(text: text.substring(lastMatchEnd)));
  }

  return TextSpan(children: spans);
}

String getVariableDisplayValue(Variable variable) {
  if (variable.type == null) return '?';
  if (variable.type == 'value') {
    return variable.values?[0].toString() ?? '?';
  } else if (variable.type == 'indicator') {
    return variable.defaultValue?.toString() ?? '?';
  }
  return '?';
}
}
