import 'package:flutter/material.dart';

// Header sẽ không cập nhật lại giao diện -> StatelessWidget
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        children: [
          // Tên Shop
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "PHShop",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),

          // Comment Spacer() để thấy khác biệt
          Spacer(),

          // Hàng được chọn xong sẽ nằm trong giỏ hàng
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 30,
              color: Colors.blue,
            ),
            onPressed: (){
              Navigator.pushNamed(context, '/gioHang');
            },
          )
        ],
      ),
    );
  }
}