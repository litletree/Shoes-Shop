import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_giay/firebase_storage.dart';
import 'package:shop_giay/nht_shop/pages/page_admin.dart';
import 'package:shop_giay/nht_shop/model/model.dart';

class PageThemSanPham_Admin extends StatefulWidget {
  const PageThemSanPham_Admin({super.key});

  @override
  State<PageThemSanPham_Admin> createState() => _PageThemSanPham_AdminState();
}

class _PageThemSanPham_AdminState extends State<PageThemSanPham_Admin> {
  XFile? _xFile;
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
        title: const Text("Thêm mới sản phẩm"),
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
                      onPressed: () {
                        if(_xFile != null){
                          uploadImage(
                              imagePath: _xFile!.path,
                              folders: ["Shoe_app"],
                              fileName: "${txtId.text}.jpg"
                          ).then(
                              (url) {
                                Shoe shoe = Shoe(
                                    id: txtId.text,
                                    ten: txtTen.text,
                                    thuongHieu: txtThuongHieu.text,
                                    gia: int.parse(txtGia.text),
                                    moTa: txtMoTa.text,
                                    soLuong: int.parse(txtSoLuong.text),
                                    anhChinh: url
                                );
                                ShoeSnapshot.themMoi(shoe).then((value) {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => PageDSSPAdmin(),)
                                  );
                                });
                              },
                          ).catchError((error){
                            print("Lỗi không upload được dữ liệu");
                          });
                        }
                      },
                      child: Text("Thêm", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
