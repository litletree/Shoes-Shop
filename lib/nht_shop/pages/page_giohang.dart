import 'package:flutter/material.dart';
import 'package:shop_giay/nht_shop/model/model.dart';
import 'package:get/get.dart';
import 'package:shop_giay/nht_shop/controller/controller.dart';

class GioHang extends StatefulWidget {
  GioHang({super.key});

  @override
  State<GioHang> createState() => _GioHangState();
}

class _GioHangState extends State<GioHang> {
  int DemSL = 0;
  // // Giam so luong
  // void GiamSL(){
  //   setState(() {
  //     if(DemSL > 0){
  //       DemSL--;
  //     }
  //   });
  // }
  // // Tang so luong
  // void TangSL(){
  //   setState(() {
  //     setState(() {
  //       DemSL++;
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final AppDataController controller = Get.find<AppDataController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Gio hang"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Obx(() {
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
              );
            },
          );
        }
      }),
    );
  }
}

// int _counter = 0;
//
// void tangsl() {
//   setState(() {
//     _counter++;
//   });
// }
// void giamsl() {
//   setState(() {
//     _counter--;
//     if(_counter == -1){
//       _counter = 0;
//     }
//   });
// }
//
// @override
// void initState() {
//   super.initState();
//   value = widget.ratingValue; // Gán giá trị từ widget.ratingValue cho value trong initState
// }