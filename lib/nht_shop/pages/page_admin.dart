import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shop_giay/connection_firebase.dart';
import 'package:shop_giay/firebase_storage.dart';
import 'package:shop_giay/nht_shop/pages/page_chitiet_sp_admin.dart';
import 'package:shop_giay/nht_shop/pages/page_capnhat_sp_admin.dart';
import 'package:shop_giay/nht_shop/pages/page_them_sp_admin.dart';
import 'package:shop_giay/nht_shop/model/model.dart';

class ShoeShopAdmin extends StatelessWidget {
  const ShoeShopAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MyFirebase(
        errorMessage: "Xảy ra lỗi",
        connectingMessage: "Đang kết nối ...",
        builder:(context) => GetMaterialApp(
          home: PageDSSPAdmin(),
          debugShowCheckedModeBanner: false,
        ),
    );
  }
}

class PageDSSPAdmin extends StatelessWidget {
  const PageDSSPAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách sản phẩm"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder(
          stream: ShoeSnapshot.getAll(),
          builder: (context, snapshot) {
            //kiểm tra và hiển thị khi có lỗi xảy ra
            if(snapshot.hasError){
              return Center(
                child: Text("Có lỗi xảy ra trong quá trình láy dữ liệu ${snapshot.error}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),),
              );
            }
            //nếu dữ liệu truyền vào không có thì sẽ quay vòng
            if(snapshot.hasData == false){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var list = snapshot.data!;
            //hien thi duoi dang mot danh sach seperated giup cho viec phan cách phần tử
            return ListView.separated(
                itemBuilder: (context, index) {
                  var shoeSnap = list[index];
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        //Nút xem chi tiết của sản phẩm
                        SlidableAction(
                          icon: Icons.remove_red_eye_rounded,
                          label: "Chi tiết",
                          backgroundColor: Colors.green,
                          onPressed: (context) {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => PageChitietSp_Admin(shoeSnap.shoe),)
                            );
                          },
                        ),
                        //Nút cập nhật sản phẩm
                        SlidableAction(
                          icon: Icons.edit,
                          label: "Cập nhật",
                          backgroundColor: Colors.blue,
                          onPressed: (context) {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => PageCapNhatSanPham_Admin(shoeSnapshot: shoeSnap),)
                            );
                          },
                        ),
                        //Nút xóa sản phẩm
                        SlidableAction(
                          icon: Icons.delete,
                          label: "Xóa",
                          backgroundColor: Colors.red,
                          onPressed: (context) async{
                            await deleteImage(folders: ["shoe_app"], fileName: "${shoeSnap.shoe.id}.jpg");
                            await shoeSnap.xoa();
                          },
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            //o day chua xong
                            child: Image.network(shoeSnap.shoe.anhChinh!)
                        ),
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Sản phẩm: ${shoeSnap.shoe.ten}", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                  Text("Giá tiền: ${shoeSnap.shoe.gia}", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(thickness: 2, color: Colors.black,),
                itemCount: list.length
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PageThemSanPham_Admin(),)
          );
        },
      ),
    );
  }
}