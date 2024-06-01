import 'package:cloud_firestore/cloud_firestore.dart';

class Shoe {
  String id;
  String ten;
  String thuongHieu;
  int gia;
  String? moTa;
  String? anhChinh;
  int? soLuong;
  List<String>? anhPhu;


  Shoe({
    required this.id,
    required this.ten,
    required this.thuongHieu,
    required this.gia,
    this.moTa,
    this.anhChinh,
    this.soLuong,
    this.anhPhu,
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
      //anhPhu: map['anhPhu'] as List<String>,
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
//
// //web tham khảo sp: https://myshoes.vn/
// class AppData{
//   List<Shoe> _dssp = [
//     Shoe(
//       id: "001",
//       ten: "NIKE DUNK LOW RETRO",
//       moTa: "Giày Nike Dunk Low Retro là dòng giày sneaker huyền thoại rất được yêu thích của Nike trên toàn thế giới. Với thiết kế đơn giản nhưng đẹp mắt, Nike Dunk Low chắc chắn là đôi giày không thể thiếu với bất cứ ai. Phần upper của giày được làm từ chất liệu da cao cấp, đế giày làm bằng cao su cực kỳ bền chắc.",
//       gia: 100,
//       thuongHieu: "Nike",
//       anhPhu: ["https://myshoes.vn/image/cache/catalog/2024/nike/nk4/giay-nike-dunk-low-nam-trang-xanh-la.03-800x800.jpg","https://myshoes.vn/image/cache/catalog/2024/nike/nk4/giay-nike-dunk-low-nam-trang-xanh-la.04-800x800.jpg", "https://myshoes.vn/image/cache/catalog/2024/nike/nk4/giay-nike-dunk-low-nam-trang-xanh-la.05-800x800.jpg"],
//       anhChinh: "https://myshoes.vn/image/cache/catalog/2024/nike/nk4/giay-nike-dunk-low-nam-trang-xanh-la.01-800x800.jpg",
//       soLuong: 10,
//     ),
//     Shoe(
//       id: "002",
//       ten: "Puma Suede",
//       moTa: "Giày Puma Suede là một trong mẫu giày Classic huyền thoại của Puma. Được làm bằng da lộn cao cấp, sang trọng, đế giày cực kỳ bền đẹp. Đây là một mẫu giày tuyệt vời dành dành cho mọi hoạt động hàng ngày.",
//       gia: 150,
//       thuongHieu: "Puma",
//       anhPhu: ["https://myshoes.vn/image/cache/catalog/2023/puma/pu01/giay-puma-suede-bulk-nam-den-trang-02-800x800.jpg","https://myshoes.vn/image/cache/catalog/2023/puma/pu01/giay-puma-suede-bulk-nam-den-trang-03-800x800.jpg", "https://myshoes.vn/image/cache/catalog/2023/puma/pu01/giay-puma-suede-bulk-nam-den-trang-05-800x800.jpg"],
//       anhChinh: "https://myshoes.vn/image/cache/catalog/2023/puma/pu01/giay-puma-suede-bulk-nam-den-trang-01-800x800.jpg",
//       soLuong: 5,
//     ),
//     Shoe(
//       id: "003",
//       ten: "ADIDAS NY 90 NỮ",
//       moTa: "Giày adidas NY 90 là mẫu giày sneaker lấy cảm hứng phong cách những năm 90. Một mẫu giày không bao giờ lỗi mốt có thiết kế basic cổ điển nhưng với công nghệ vật liệu hiện đại cao cấp.",
//       gia: 180,
//       thuongHieu: "Adidas",
//       anhPhu: ["https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-ny-90-nu-trang-03-800x800.jpg","https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-ny-90-nu-trang-02-800x800.jpg", "https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-ny-90-nu-trang-06-800x800.jpg", "https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-ny-90-nu-trang-04-800x800.jpg"],
//       anhChinh: "https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-ny-90-nu-trang-01-800x800.jpg",
//       soLuong: 7,
//     ),
//     Shoe(
//       id: "004",
//       ten: "ADIDAS STAN SMITH CS",
//       moTa: "Giày Adidas Stan Smith CS mẫu giày huyền thoại, một trong những dòng sản phẩm nổi tiếng nhất trong lịch sử của Adidas với thiết kế không bao giờ lỗi mốt, đẹp mãi với thời gian.",
//       gia: 800,
//       thuongHieu: "Adidas",
//       anhPhu: ["https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-stan-smith-cs-trang-nam-trang-02-800x800.jpg", "https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-stan-smith-cs-trang-nam-trang-03-800x800.jpg", "https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-stan-smith-cs-trang-nam-trang-06-800x800.jpg"],
//       anhChinh: "https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-stan-smith-cs-trang-nam-trang-01-800x800.jpg",
//       soLuong: 8,
//     ),
//   ];
//   List<Shoe> get dssp => _dssp;
// }