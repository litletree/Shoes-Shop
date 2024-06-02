import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';


Future<String> uploadImage({required String imagePath, required List<String> folders, required String fileName}) async{
  String downloadUrl;
  //tạo đối tượng FirebaseStorage
  FirebaseStorage _storage = FirebaseStorage.instance;

  //1. Thiết lập đường dẫn đến firebase storage
  Reference reference = _storage.ref();
  for(String f in folders)
    reference = reference.child(f);
  reference = reference.child(fileName);

  //2.Thiết lập Metadata
  final metadata = SettableMetadata(
    contentType: 'image/jpeg',
    customMetadata: {'picked-file-path': imagePath},
  );

  //3. upload ảnh lên Firebase storage và trả về đường dẫn
  try{
    if (kIsWeb) {
      await reference.putData(await XFile(imagePath).readAsBytes(), metadata);
    } else {
      await reference.putFile(File(imagePath), metadata);
    }
    downloadUrl = await reference.getDownloadURL();
    return downloadUrl;
  }on FirebaseException catch (e){
    print("lỗi upload file ảnh lên firebase ${e.toString()}");
    return Future.error("loi upload file");
  }
}

Future<void> deleteImage({required List<String> folders, required String fileName}){
  FirebaseStorage _storage = FirebaseStorage.instance;

  Reference reference = _storage.ref();
  for(String f in folders)
    reference = reference.child(f);
  reference = reference.child(fileName);
  return reference.delete();
}