import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:shop_giay/DS_SanPham/models.dart';
import 'package:shop_giay/DS_SanPham/controller.dart';

class TrangChu extends StatelessWidget {
  const TrangChu({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppDataBindings(),
      debugShowCheckedModeBanner: false,
      home: const PageShoesStore(),
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
                      Get.to(PageChiTietSp(shoe: shoe, ratingValue: shoe.ratings!,));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
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
                            Stack(
                              children: [
                                shoe.mainImage != null
                                    ? Image.network(
                                  shoe.mainImage!,
                                  width: double.infinity,
                                  height: 300,
                                  fit: BoxFit.cover,
                                )
                                    : Icon(Icons.image_not_supported),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shoe.brand,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    shoe.tensp,
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
  Shoes shoe;
  double ratingValue;

  PageChiTietSp({required this.shoe, required this.ratingValue, super.key});

  @override
  _PageChiTietSpState createState() => _PageChiTietSpState();
}

class _PageChiTietSpState extends State<PageChiTietSp> {
  double value = 0.0;


  @override
  void initState() {
    super.initState();
    value = widget.ratingValue; // Gán giá trị từ widget.ratingValue cho value trong initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.shoe.tensp.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.shoe.mainImage != null || (widget.shoe.images != null && widget.shoe.images!.isNotEmpty))
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
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
                    if (widget.shoe.mainImage != null)
                      Image.network(
                        widget.shoe.mainImage!,
                        fit: BoxFit.cover,
                      ),
                    if (widget.shoe.images != null)
                      ...widget.shoe.images!.map((imageUrl) => Image.network(
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
                  "${widget.shoe.gia}.000đ",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
                SizedBox(width: 90,),
                RatingStars(
                  value: value,
                  onValueChanged: (v) {
                    setState(() {
                      value = v;
                      widget.shoe.ratings = v;
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
                )
              ],
            ),
            //  code here to continue
          ],
        ),
      ),
    );
  }
}
