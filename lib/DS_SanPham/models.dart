class Shoes {
  String idsp;
  String tensp;
  String? mota;
  int gia;
  List<String>? sizes;
  String brand;
  String category;
  List<String>? images;
  String? mainImage;
  double? ratings;
  int? quantity;
  String productCode;

  Shoes({
    required this.idsp,
    required this.tensp,
    this.mota,
    required this.gia,
    this.sizes,
    required this.brand,
    required this.category,
    this.images,
    this.mainImage,
    this.ratings,
    this.quantity,
    required this.productCode,
  });
}

class GH_Item{
  String idSp;
  int sl;
  GH_Item({required this.idSp, required this.sl});
}

//web tham khảo sp: https://myshoes.vn/
class AppData{
  List<Shoes> _dssp = [
    Shoes(
        idsp: "001",
        tensp: "Running Shoes",
        mota: "Comfortable running shoes.",
        gia: 100,
        sizes: ["41","42","43","44"],
        brand: "Nike",
        category: "Sports",
        images: ["https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/b6ab6e70-abf6-4b09-b93e-b7d9160e1efc/infinityrn-4-road-running-shoes-SFXkMs.png","https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/51effd81-5500-4d52-ba0e-8ed4f23f6d93/infinityrn-4-road-running-shoes-SFXkMs.png", "https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/24f4e231-ea52-45d6-b435-f18e366df4be/infinityrn-4-road-running-shoes-SFXkMs.png"],
        mainImage: "https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/84dadb96-8116-48db-b489-093a5eebe310/infinityrn-4-road-running-shoes-SFXkMs.png",
        ratings: 4.5,
        quantity: 10,
        productCode: "RUN100"
    ),
    Shoes(
        idsp: "002",
        tensp: "Puma Suede",
        mota: "Giày Puma Suede là một trong mẫu giày Classic huyền thoại của Puma. Được làm bằng da lộn cao cấp, sang trọng, đế giày cực kỳ bền đẹp. Đây là một mẫu giày tuyệt vời dành dành cho mọi hoạt động hàng ngày.",
        gia: 150,
        sizes: ["41","42","43","44"],
        brand: "Puma",
        category: "Giày đi chơi",
        images: ["https://myshoes.vn/image/cache/catalog/2023/puma/pu01/giay-puma-suede-bulk-nam-den-trang-02-800x800.jpg","https://myshoes.vn/image/cache/catalog/2023/puma/pu01/giay-puma-suede-bulk-nam-den-trang-03-800x800.jpg", "https://myshoes.vn/image/cache/catalog/2023/puma/pu01/giay-puma-suede-bulk-nam-den-trang-05-800x800.jpg"],
        mainImage: "https://myshoes.vn/image/cache/catalog/2023/puma/pu01/giay-puma-suede-bulk-nam-den-trang-01-800x800.jpg",
        ratings: 5.5,
        quantity: 5,
        productCode: "MSP293"
    ),
    Shoes(
        idsp: "003",
        tensp: "ADIDAS NY 90 NỮ",
        mota: "Giày adidas NY 90 là mẫu giày sneaker lấy cảm hứng phong cách những năm 90. Một mẫu giày không bao giờ lỗi mốt có thiết kế basic cổ điển nhưng với công nghệ vật liệu hiện đại cao cấp.",
        gia: 180,
        sizes: ["38","39","40","41"],
        brand: "Adidas",
        category: "Giày đi chơi",
        images: ["https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-ny-90-nu-trang-03-800x800.jpg","https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-ny-90-nu-trang-02-800x800.jpg", "https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-ny-90-nu-trang-06-800x800.jpg", "https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-ny-90-nu-trang-04-800x800.jpg"],
        mainImage: "https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-ny-90-nu-trang-01-800x800.jpg",
        ratings: 3.5,
        quantity: 7,
        productCode: "MSA625"
    ),
    Shoes(
        idsp: "004",
        tensp: "ADIDAS STAN SMITH CS",
        mota: "Giày Adidas Stan Smith CS mẫu giày huyền thoại, một trong những dòng sản phẩm nổi tiếng nhất trong lịch sử của Adidas với thiết kế không bao giờ lỗi mốt, đẹp mãi với thời gian.",
        gia: 800,
        sizes: ["38","39","40","41"],
        brand: "Adidas",
        category: "Giày đi chơi",
        images: ["https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-stan-smith-cs-trang-nam-trang-02-800x800.jpg", "https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-stan-smith-cs-trang-nam-trang-03-800x800.jpg", "https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-stan-smith-cs-trang-nam-trang-06-800x800.jpg"],
        mainImage: "https://myshoes.vn/image/cache/catalog/2024/adidas/ad3/giay-adidas-stan-smith-cs-trang-nam-trang-01-800x800.jpg",
        ratings: 4.5,
        quantity: 8,
        productCode: "MSA627"
    ),
  ];
  List<Shoes> get dssp => _dssp;
}