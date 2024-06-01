import 'package:flutter/material.dart';
import 'package:shop_giay/nht_shop/pages/page_giohang.dart';
import 'package:shop_giay/nht_shop/pages/page_trangchu.dart';
import 'package:shop_giay/nht_shop/pages/page_lichsu.dart';
import 'package:shop_giay/nht_shop/pages/page_admin.dart';
import 'package:get/get.dart';

import 'nht_shop/controller/controller.dart';

class PageHome extends StatefulWidget {
  PageHome({super.key});
  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final AppDataController controller = Get.find<AppDataController>();

    return Scaffold(
      // Gọi Header đã tùy chỉnh
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "NTHShop",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        // Giỏ hàng
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 30,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GioHang()),
              );
            },
          ),
        ],
      ),

      body: _buildBody(context, index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.home, color: Colors.blue,),
              icon: Icon(Icons.home_outlined, color: Colors.blue,),
              label: "Trang chủ"
          ),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.shopping_bag, color: Colors.blue,),
              icon: Icon(Icons.shopping_bag_outlined, color: Colors.blue,),
              label: "Lịch sử mua hàng"
          ),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.admin_panel_settings, color: Colors.blue,),
              icon: Icon(Icons.admin_panel_settings_outlined, color: Colors.blue,),
              label: "Admin"
          )
        ],
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }

  _buildBody(BuildContext context, int index) {
    switch (index) {
      case 0:
        return _buildHome(context);
      case 1:
        return _buildLSMH(context);
      case 2:
        return _buildAdmin(context);
    }
  }

  _buildHome(BuildContext context) {
    return PageTrangChu();
  }

  _buildLSMH(BuildContext context) {
    return PageLichSuMuaHang();
  }

  _buildAdmin(BuildContext context){
    return ShoeShopAdmin();
  }
}

 