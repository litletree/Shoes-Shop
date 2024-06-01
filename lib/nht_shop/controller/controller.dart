import 'package:get/get.dart';
import 'package:shop_giay/nht_shop/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppDataController extends GetxController {
  // List<Shoe> _dssp = AppData().dssp;
  List<Shoe> _dssp = [];
  List<Shoe> get dssp => _dssp;
  List<GH_Item> _gioHang = [];
  List<GH_Item> get gioHang => _gioHang;
  int get slMH_GioHang => _gioHang.length;

  static AppDataController get instance => Get.find<AppDataController>();

  @override
  void onReady() {
    super.onReady();
    fetchShoes();
  }

  void fetchShoes() {
    FirebaseFirestore.instance.collection('Shoes').snapshots().listen((querySnapshot) {
      _dssp = querySnapshot.docs.map((doc) => Shoe.fromJson(doc.data() as Map<String, dynamic>)).toList();
      update(['List_sp']); // Notify GetBuilder to update the UI
    });
  }


}

class AppDataBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AppDataController());
  }
}