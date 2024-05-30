import 'package:flutter/material.dart';
import 'package:shop_giay/header/gio_hang.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
