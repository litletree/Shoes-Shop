import 'package:flutter/material.dart';

class LichSuMuaHang extends StatefulWidget {
  const LichSuMuaHang({super.key});

  @override
  State<LichSuMuaHang> createState() => _LichSuMuaHangState();
}

class _LichSuMuaHangState extends State<LichSuMuaHang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LICH SU MUA HANG"),
      ),
    );
  }
}
