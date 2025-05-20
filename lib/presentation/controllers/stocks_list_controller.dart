import 'package:get/get.dart';
import 'package:stock_listing_application/domain/models/stock_list_model.dart';
import 'package:stock_listing_application/provider/api_provider.dart';

class StocksListController extends GetxController {
  final ApiProvider apiProvider = ApiProvider();

  var isLoading = true.obs;
  var displayStockList = <StockListModel>[].obs;

  @override
  void onInit() {
    getList();
    super.onInit();
  }

  void getList() async {
    try {
      isLoading(true);
      var stockList = await apiProvider.fetchList();
      displayStockList.assignAll(stockList);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
