import 'package:flutter/material.dart';
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
              itemCount: controller.slMH_GioHang,
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
                Text("Tổng cộng:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Obx(() {
                  int tongHoaDon = controller.gioHang.fold(0, (sum, item) {
                    final shoe = controller.dssp.firstWhere((shoe) => shoe.id == item.idSp);
                    return sum + (shoe.gia * item.sl);
                  });
                  return Text("$tongHoaDon.000 VND", style: TextStyle(fontSize: 16),);
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
                xoaSPkhoiGH();
              },
              child: Text("Đặt hàng"),
            ),
          ),
        ],
      ),
    );
  }

  // Ấn đặt hàng thì sản phẩm trong giỏ hàng bị xóa
  void xoaSPkhoiGH() async {
    for (var item in List.from(controller.gioHang)) {
      controller.xoaKhoiGH(item.idSp);
    }
  }
}

