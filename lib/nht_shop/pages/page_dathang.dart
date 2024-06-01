import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop_giay/nht_shop/controller/controller.dart';

class PageDatHang extends StatelessWidget {
  final AppDataController controller = Get.find<AppDataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hóa đơn"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "DANH SÁCH MUA HÀNG",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.gioHang.length,
              itemBuilder: (context, index) {
                final item = controller.gioHang[index];
                final shoe = controller.dssp.firstWhere((shoe) => shoe.id == item.idSp);
                return ListTile(
                  title: Text(shoe.ten),
                  subtitle: Text('Số lượng: ${item.sl}'),
                  trailing: Text('${shoe.gia * item.sl}.000 VND'), // Tính tổng giá của sản phẩm
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tổng cộng:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Obx(() {
                  int total = controller.gioHang.fold(0, (sum, item) {
                    final shoe = controller.dssp.firstWhere((shoe) => shoe.id == item.idSp);
                    return sum + (shoe.gia * item.sl);
                  });
                  return Text(
                    "$total.000 VND",
                    style: TextStyle(fontSize: 16),
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Họ và tên",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Địa chỉ giao hàng",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                datHang();
              },
              child: Text("Đặt hàng"),
            ),
          ),
        ],
      ),
    );
  }

  void datHang() async {
    // Duyệt qua từng sản phẩm trong giỏ hàng
    for (var item in controller.gioHang) {
      final shoe = controller.dssp.firstWhere((shoe) => shoe.id == item.idSp);
      int newSoLuong = shoe.soLuong! - item.sl;
      if (newSoLuong <= 0) {
        // Nếu số lượng mới <= 0, xóa sản phẩm khỏi Firebase
        await FirebaseFirestore.instance.collection("Shoes").doc(shoe.id).delete();
      } else {
        // Ngược lại, cập nhật số lượng mới cho sản phẩm trên Firebase
        await FirebaseFirestore.instance.collection("Shoes").doc(shoe.id).update({"soLuong": newSoLuong});
      }
    }

    // Xóa giỏ hàng
    controller.gioHang.clear();

    // Hiển thị thông báo "Đặt hàng thành công"
    Get.snackbar(
      "Thông báo",
      "Đặt hàng thành công",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
