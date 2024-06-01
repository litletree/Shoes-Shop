import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:shop_giay/connection_firebase.dart';
import 'package:shop_giay/nht_shop/controller/controller.dart';
import 'package:shop_giay/nht_shop/model/model.dart';

class PageTrangChu extends StatelessWidget {
  const PageTrangChu({super.key});

  @override
  Widget build(BuildContext context) {
    return MyFirebase(
        errorMessage: "Loi ket noi firebase",
        connectingMessage: "Dang ket noi",
        builder: (context) => GetMaterialApp(
          initialBinding: AppDataBindings(),
          debugShowCheckedModeBanner: false,
            home: PageShoesStore(),
        ),
    );
  }
}

class PageShoesStore extends StatelessWidget {
  const PageShoesStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    "SẢN PHẨM MỚI",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                    ),
                  ),
                  SizedBox(height: 50),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 2,
                      width: 80, // Adjust width as needed
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8), // Space between the underline and the hashtag
              Text(
                "#SHOES",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    decoration: TextDecoration.none
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GetBuilder<AppDataController>(
            init: AppDataController.instance,
            id: "List_sp",
            builder: (controller) {
              return GridView.extent(
                maxCrossAxisExtent: 500,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: controller.dssp.map(
                      (shoe) => GestureDetector(
                    onTap: () {
                      // Thực hiện hành động khi nhấn vào sản phẩm
                      Get.to(PageChiTietSp(shoe: shoe));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: Text(
                                    shoe.thuongHieu.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              height: 20,
                              width: double.infinity,
                              color: Colors.blue,
                            ),
                            shoe.anhChinh != null
                                ? Image.network(
                              shoe.anhChinh!,
                              width: double.infinity,
                              height: 308,
                              fit: BoxFit.cover,
                            )
                                : Icon(Icons.image_not_supported),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shoe.ten,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        "${shoe.gia}.000đ",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}


class PageChiTietSp extends StatefulWidget {
  Shoe shoe;

  PageChiTietSp({required this.shoe, super.key});

  @override
  _PageChiTietSpState createState() => _PageChiTietSpState();
}

class _PageChiTietSpState extends State<PageChiTietSp> {
  double value = 0.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.shoe.ten.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.shoe.anhChinh != null || (widget.shoe.anhPhu != null && widget.shoe.anhPhu!.isNotEmpty))
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ImageSlideshow(
                      width: double.infinity,
                      height: 390,
                      initialPage: 0,
                      indicatorColor: Colors.blue,
                      indicatorBackgroundColor: Colors.grey,
                      children: [
                        if (widget.shoe.anhChinh != null)
                          Image.network(
                            widget.shoe.anhChinh!,
                            fit: BoxFit.cover,
                          ),
                        if (widget.shoe.anhPhu != null)
                          ...widget.shoe.anhPhu!.map((imageUrl) => Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          )),
                      ],
                      onPageChanged: (value) {
                        print('Page changed: $value');
                      },
                      autoPlayInterval: null,
                      isLoop: false,
                    ),
                  )
                else
                  Center(child: Text('No images available')),
                SizedBox(height: 15),
                Row(
                    children: [
                      Text(
                        "${widget.shoe.gia}.000 VND",
                        style: TextStyle(fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 100,),
                    ]
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    RatingStars(
                      value: value,
                      onValueChanged: (v) {
                        setState(() {
                          value = v;
                        });
                      },
                      starBuilder: (index, color) => Icon(
                        Icons.star,
                        color: color,
                      ),
                      starCount: 5,
                      starSize: 20,
                      valueLabelColor: const Color(0xff9b9b9b),
                      valueLabelTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0),
                      valueLabelRadius: 10,
                      maxValue: 5,
                      starSpacing: 2,
                      maxValueVisibility: true,
                      valueLabelVisibility: true,
                      animationDuration: Duration(milliseconds: 1000),
                      valueLabelPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                      valueLabelMargin: const EdgeInsets.only(right: 8),
                      starOffColor: const Color(0xffe7e8ea),
                      starColor: Colors.yellow,
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Text("THƯƠNG HIỆU SẢN PHẨM: ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Text(widget.shoe.thuongHieu.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),),
                  ],
                ),
                SizedBox(height: 5,),
                Text("MÔ TẢ SẢN PHẨM: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                SizedBox(height: 10),
                Text(widget.shoe.moTa!, style: TextStyle(fontSize: 16),),
                SizedBox(height: 15,),
                Text("HÀNG CÒN TRONG KHO: ${widget.shoe.soLuong}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        AppDataController.instance.addToCart(widget.shoe.id, 1); // Thêm 1 sản phẩm vào giỏ hàng
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, // Màu nền của nút
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Text("THÊM VÀO GIỎ HÀNG",style: TextStyle(fontSize: 30, color: Colors.white),),
                            SizedBox(width: 5,),
                            Icon(Icons.add_shopping_cart,color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    // ElevatedButton(
                    //   onPressed: () {
                    //
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.red, // Màu nền của nút
                    //   ),
                    //   child: Container(
                    //     child: Row(
                    //       children: [
                    //         Text("ĐẶT HÀNG",style: TextStyle(fontSize: 13, color: Colors.white),),
                    //         SizedBox(width: 5,),
                    //         Icon(Icons.monetization_on_outlined, color: Colors.white,)
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}