import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PageLichSuMuaHang extends StatefulWidget {
  const PageLichSuMuaHang({super.key});

  @override
  State<PageLichSuMuaHang> createState() => _PageLichSuMuaHangState();
}

class _PageLichSuMuaHangState extends State<PageLichSuMuaHang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch sử mua hàng"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          var orders = snapshot.data!.docs;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order = orders[index];
              return ListTile(
                title: Text('Order #${order.id}'),
                subtitle: Text('Total: \$${order['total']}'),
              );
            },
          );
        },
      ),
    );
  }
}
