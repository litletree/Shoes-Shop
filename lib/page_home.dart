import 'package:flutter/material.dart';
import 'package:shop_giay/header_code/Header.dart';

// Trang Home

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Dùng ListView cho thuộc tính body
      // để hiển thị các widget dưới dạng cuộn
      body: ListView(
        children: [
          // Trang Header
          Header(),

          // Nội dung chính của APP
          Container(
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Colors.blue
            ),
            child: Column(
              children: [
                // Thanh tìm kiếm
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Tìm kiếm sản phẩm"
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.search_rounded,
                        size: 27,
                        color: Colors.blue,
                      )
                    ],
                  ),
                )

              ],
            ),
          ),

          //
        ],
      ),
    );
  }
}


