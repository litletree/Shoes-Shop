import 'package:flutter/material.dart';

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
        title: Text("LICH SU MUA HANG"),
      ),
    );
  }
}
