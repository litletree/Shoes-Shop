import 'package:get/get.dart';
import 'package:shop_giay/nht_shop/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppDataController extends GetxController {
  List<Shoe> _dssp = [];
  List<Shoe> get dssp => _dssp;
  List<GH_Item> _gioHang = <GH_Item>[].obs;
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
      update(['List_sp']);
    });
  }

  void addToCart(String idSp, int sl) {
    var item = _gioHang.firstWhereOrNull((element) => element.idSp == idSp);
    if (item == null) {
      _gioHang.add(GH_Item(idSp: idSp, sl: sl));
    } else {
      item.sl += sl;
    }
    update(['gioHang']);
  }

  void updateCartItem(String idSp, int sl) {
    var item = _gioHang.firstWhereOrNull((element) => element.idSp == idSp);
    if (item != null) {
      item.sl = sl;
      update(['gioHang']);
    }
  }

  void removeCartItem(String idSp) {
    _gioHang.removeWhere((element) => element.idSp == idSp);
    update(['gioHang']);
  }
}

class AppDataBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AppDataController());
  }
}
