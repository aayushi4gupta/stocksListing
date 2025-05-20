import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:stock_listing_application/presentation/controllers/stocks_list_controller.dart';
import 'package:stock_listing_application/presentation/utils/utility.dart';
import 'package:stock_listing_application/presentation/views/detail_view.dart';

class StocksView extends StatelessWidget {
  final StocksListController controller = Get.put(StocksListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stocks')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return Container(
          color: Colors.black,
          height: 420,
          padding: EdgeInsets.all(16),
          child: ListView.separated(
            itemCount: controller.displayStockList.length,
            separatorBuilder: (_, __)=>const Divider(color: Colors.white,
                thickness: 1.2,
                height: 30,),
            itemBuilder: (_, index) {
              final stock = controller.displayStockList[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.to(() => DetailView(item: stock));
                              },
                              child: Text(stock.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white
                              ),
                            )
                            ),
                            const SizedBox(height: 4),
                            Text(
                              stock.tag,
                              style: TextStyle(
                                color:  Utility.getColorFromString(stock.color),
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white
                              ),
                            ),
                ])
                  )
                ],
              );
            },
          ),
        );
      }),
    );
  }
}