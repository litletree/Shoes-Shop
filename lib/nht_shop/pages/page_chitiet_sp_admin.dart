import 'package:flutter/material.dart';
import 'package:shop_giay/nht_shop/model/model.dart';

class PageChitietSp_Admin extends StatelessWidget {

  PageChitietSp_Admin(this.shoe, {super.key});
  Shoe shoe;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết sản phẩm"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ảnh chính của sản phẩm", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Container(
              width: w * 0.9,
              child: shoe.anhChinh != null ? Image.network(shoe.anhChinh!) : Icon(Icons.image_not_supported_outlined),
            ),
            Text("Id sản phẩm: ${shoe.id}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
            SizedBox(height: 15,),
            Text("Tên sản phẩm: ${shoe.ten}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text("Giá sản phẩm: ${shoe.gia} VND", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text("Thương hiệu sản phẩm: ${shoe.thuongHieu}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text("Mô tả sản phẩm: ${shoe.moTa}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text("Số lượng trong kho: ${shoe.soLuong}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
