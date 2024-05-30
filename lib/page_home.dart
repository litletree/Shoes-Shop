import 'package:flutter/material.dart';
import 'package:shop_giay/header/Header.dart';
import 'Footer/trang_chu.dart';
import 'Footer/lich_su.dart';
import 'Footer/admin.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});
  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gọi Header đã tùy chỉnh
      appBar: Header(),
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
    return TrangChu();
  }

  _buildLSMH(BuildContext context) {
    return LichSuMuaHang();
  }

  _buildAdmin(BuildContext context){
    return Admin();
  }
}
