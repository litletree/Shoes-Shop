import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_giay/firebase_options.dart';

class MyFirebase extends StatefulWidget {
  final String errorMessage;
  final String connectingMessage;
  final Widget Function(BuildContext context) builder;
  const MyFirebase({Key ? key,
    required this.errorMessage,
    required this.connectingMessage,
    required this.builder}) : super(key: key);
  @override
  State<MyFirebase> createState() => _MyFirebaseState();
}

class _MyFirebaseState extends State<MyFirebase> {
  bool ketNoi = false;
  bool loi = false;

  @override
  Widget build(BuildContext context) {
    if(loi==true){
      return
          Container(
            color: Colors.white,
            child: Center(
              child: Text("loi 1 ${widget.errorMessage}", style: TextStyle(fontSize: 16),),
            ),
          );
    }else{
      if(ketNoi == false){
        return Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text("loi 2 ${widget.connectingMessage}", style: TextStyle(fontSize: 16),)
              ],
            ),
          ),
        );
      }else{
        return widget.builder(context);
      }
    }
  }

  @override
  void initState(){
    super.initState();
    _khoiTaoFirebase();
  }

  _khoiTaoFirebase(){
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) {
    setState((){
      ketNoi = true;
    });
  }).catchError((error){
    setState((){
      loi = true;
    });
  }).whenComplete((){
        print("Hoan tat ket noi firebase");
  });
  }
}



