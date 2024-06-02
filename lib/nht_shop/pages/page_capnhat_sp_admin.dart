import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_giay/firebase_storage.dart';
import 'package:shop_giay/nht_shop/pages/page_admin.dart';
import 'package:shop_giay/nht_shop/model/model.dart';

class PageCapNhatSanPham_Admin extends StatefulWidget {
  ShoeSnapshot shoeSnapshot;
  PageCapNhatSanPham_Admin({super.key, required this.shoeSnapshot});

  @override
  State<PageCapNhatSanPham_Admin> createState() => _PageCapNhatSanPham_AdminState();
}

class _PageCapNhatSanPham_AdminState extends State<PageCapNhatSanPham_Admin> {
  XFile? _xFile;
  String? imageurl;
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtThuongHieu = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtMoTa = TextEditingController();
  TextEditingController txtSoLuong = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cập nhật sản phẩm"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text("Ảnh chính của sản phẩm"),
              //Khung ảnh chính của sản phẩm
              Center(
                child: Container(
                    width: w * 0.8,
                    height: w * 0.8 * 2/3,
                    child: _xFile == null ? Icon(Icons.image_not_supported_outlined) : Image.file(File(_xFile!.path))),
              ),
              //Nút chọn ảnh chính
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () async{
                      _xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if(_xFile != null){
                        setState(() {
                        });
                      }
                    },
                    child: Text("Chọn ảnh", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black,),),
                  )
                ],
              ),
              //Text field bắt đầu từ đây
              //Text field chọn Id sản phẩm
              TextField(
                controller: txtId,
                decoration: const InputDecoration(
                    labelText: "Id sản phẩm",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white
                ),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 15,),
              //Text field chọn tên sản phẩm
              TextField(
                controller: txtTen,
                decoration: const InputDecoration(
                    labelText: "Tên sản phẩm",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white
                ),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 15,),
              //Text field chọn nhãn hàng của sản phẩm
              TextField(
                controller: txtThuongHieu,
                decoration: const InputDecoration(
                    labelText: "Nhãn hàng sản phẩm",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white
                ),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 15,),
              //Text field chọn giá sản phẩm
              TextField(
                controller: txtGia,
                decoration: const InputDecoration(
                    labelText: "Giá sản phẩm",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 15,),
              //Text field mô tả sản phẩm
              TextField(
                maxLines: null,
                controller: txtMoTa,
                decoration: const InputDecoration(
                    labelText: "Mô tả sản phẩm",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white
                ),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 15,),
              //Text field số lượng hàng hóa
              TextField(
                controller: txtSoLuong,
                decoration: const InputDecoration(
                    labelText: "Số lượng sản phẩm",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        Shoe shoe = Shoe(
                            id: txtId.text,
                            ten: txtTen.text,
                            thuongHieu: txtThuongHieu.text,
                            gia: int.parse(txtGia.text),
                            moTa: txtMoTa.text,
                            soLuong: int.parse(txtSoLuong.text)
                        );
                        if(_xFile != null){
                          showMySnackBar(context, "Đang cập nhật sản phẩm ...", 3);
                          imageurl = await uploadImage(
                              imagePath: _xFile!.path,
                              folders: ["shoe_app"],
                              fileName: "${txtId.text}.jpg"
                          );
                          if(imageurl != null){
                            shoe.anhChinh = imageurl;
                            _capNhatSP(shoe);
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => PageDSSPAdmin(),)
                            );
                          }else{
                            showMySnackBar(context, "Cập nhật sản phẩm không thành công", 3);
                          }
                        }else{
                          showMySnackBar(context, "Đang cập nhật sản phẩm ...", 10);
                          shoe.anhChinh = widget.shoeSnapshot.shoe.anhChinh;
                          _capNhatSP(shoe);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => PageDSSPAdmin(),)
                          );
                        }

                      },
                      child: Text("Cập nhật", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState(){
    txtId.text = widget.shoeSnapshot.shoe.id;
    txtTen.text = widget.shoeSnapshot.shoe.ten;
    txtThuongHieu.text = widget.shoeSnapshot.shoe.thuongHieu;
    txtGia.text = widget.shoeSnapshot.shoe.gia.toString();
    txtMoTa.text = widget.shoeSnapshot.shoe.moTa.toString();
    txtSoLuong.text = widget.shoeSnapshot.shoe.soLuong.toString();
  }

  _capNhatSP(Shoe shoe) async{
    widget.shoeSnapshot.capNhat(shoe).then((value) => showMySnackBar(
        context, "Cập nhật sản phẩm ${txtTen.text} thành công", 3),
    ).catchError((error){
      showMySnackBar(context, "Cập nhật sản phẩm ${txtTen.text} không thành công", 3);
    });
  }
}

showMySnackBar(BuildContext context, String thongBao, int giay){
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(thongBao),
          duration: Duration(seconds: giay),
      )
  );
}
