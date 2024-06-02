import 'package:cloud_firestore/cloud_firestore.dart';

class Shoe {
  String id;
  String ten;
  String thuongHieu;
  int gia;
  String? moTa;
  String? anhChinh;
  int? soLuong;


  Shoe({
    required this.id,
    required this.ten,
    required this.thuongHieu,
    required this.gia,
    this.moTa,
    this.anhChinh,
    this.soLuong,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'ten': this.ten,
      'thuongHieu': this.thuongHieu,
      'gia': this.gia,
      'moTa': this.moTa,
      'anhChinh': this.anhChinh,
      'soLuong': this.soLuong,
      //'anhPhu': this.anhPhu,
    };
  }

  factory Shoe.fromJson(Map<String, dynamic> map) {
    return Shoe(
      id: map['id'] as String,
      ten: map['ten'] as String,
      thuongHieu: map['thuongHieu'] as String,
      gia: map['gia'] as int,
      moTa: map['moTa'] as String,
      anhChinh: map['anhChinh'] as String,
      soLuong: map['soLuong'] as int,
    );
  }
}

class ShoeSnapshot{
  Shoe shoe;
  DocumentReference ref;

  ShoeSnapshot({
    required this.shoe,
    required this.ref,
  });

  factory ShoeSnapshot.fromMap(DocumentSnapshot docSnap) {
    return ShoeSnapshot(
      shoe: Shoe.fromJson(docSnap.data() as Map<String, dynamic>),
      ref: docSnap.reference,
    );
  }

  //Hàm thêm mới sản phẩm vào trong firebase
  static Future<DocumentReference> themMoi(Shoe shoe) async{
    return FirebaseFirestore.instance.collection("Shoes").add(shoe.toJson());
  }

  //Hàm cập nhật sản phẩm vào trong firebase
  Future<void> capNhat(Shoe shoe)async{
    return ref.update(shoe.toJson());
  }

  //Hàm xóa sản phẩm trong firebase
  Future<void> xoa()async{
    return ref.delete();
  }

  //Truy vấn dữ liệu thời gian thực
  static Stream<List<ShoeSnapshot>> getAll(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("Shoes").snapshots();
    return sqs.map(
            (event) => event.docs.map(
              (docSnap) => ShoeSnapshot.fromMap(docSnap),
        ).toList()
    );
  }
}

class GH_Item{
  String idSp;
  int sl;
  GH_Item({
    required this.idSp,
    required this.sl,
  });
}