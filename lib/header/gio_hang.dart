import 'package:flutter/material.dart';

class GioHang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ Hàng', style: TextStyle(color: Colors.white),),
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Code giỏ hàng ở đây'),
      ),
    );
  }
}