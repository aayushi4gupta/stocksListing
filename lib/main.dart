import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:stock_listing_application/presentation/views/detail_view.dart';
import 'package:stock_listing_application/presentation/views/stocks_view.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: StocksView(),
  ));
}

