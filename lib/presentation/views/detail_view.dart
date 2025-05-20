import 'package:flutter/material.dart';
import 'package:stock_listing_application/domain/models/criteria_model.dart';
import 'package:stock_listing_application/domain/models/stock_list_model.dart';
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
                itemCount: item.criteria.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final value = item.criteria[index];
                  return buildRichCriteria(value.text, value.variable ?? {});
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
  // Format variable text
  Widget buildRichCriteria(String text, Map<String, dynamic> variable) {
    final RegExp regExp = RegExp(r"\$(\d+)");
    final List<TextSpan> spans = [];

    int start = 0;
    for (final match in regExp.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }

      final variableKey = "\$${match.group(1)}";
      final value = extractDisplayValue(variable[variableKey]);
      spans.add(TextSpan(
        text: "($value)",
        style: const TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
      ));

      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 18, color: Colors.white),
        children: spans,
      ),
    );
  }

  String extractDisplayValue(dynamic value) {
    if (value == null) return "?";
    if (value is Map && value.containsKey("values")) {
      return value["values"].isNotEmpty ? value["values"].first.toString() : "?";
    }
    return value.toString();
  }

}
