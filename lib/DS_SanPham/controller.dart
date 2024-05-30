import 'package:get/get.dart';
import 'package:shop_giay/DS_SanPham/models.dart';

class AppDataController extends GetxController {
  List<Shoes> _dssp = AppData().dssp;
  List<Shoes> get dssp => _dssp;

  static AppDataController get instance => Get.find<AppDataController>();

  @override
  void onReady() {
    super.onReady();
  }
}

class AppDataBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AppDataController());
  }
}