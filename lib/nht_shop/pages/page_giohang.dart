import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_giay/nht_shop/controller/controller.dart';
import 'package:shop_giay/nht_shop/pages/page_dathang.dart';

class GioHang extends StatefulWidget {
  GioHang({Key? key}) : super(key: key);

  @override
  State<GioHang> createState() => _GioHangState();
}

class _GioHangState extends State<GioHang> {
  final AppDataController controller = Get.find<AppDataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Obx((){
        if (controller.gioHang.isEmpty) {
          return Center(child: Text("Giỏ hàng trống"));
        } else {
          return ListView.builder(
            itemCount: controller.gioHang.length,
            itemBuilder: (context, index) {
              final item = controller.gioHang[index];
              final shoe = controller.dssp.firstWhere((shoe) => shoe.id == item.idSp);
              return ListTile(
                title: Text(shoe.ten),
                subtitle: Text('Số lượng: ${item.sl}'),
                trailing: Row (
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton (
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (item.sl > 1) {
                          controller.updateCartItem(item.idSp, item.sl - 1);
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        controller.updateCartItem(item.idSp, item.sl + 1);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        controller.removeCartItem(item.idSp);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: ElevatedButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageDatHang())
          );
        },
        child: Text("Đặt hàng"),
      ),
    );
  }
}
