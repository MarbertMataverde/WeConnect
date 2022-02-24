import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ImageDetails extends StatelessWidget {
  const ImageDetails({Key? key, required this.imageList}) : super(key: key);

  final List imageList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: imageList.length == 1
                ? Hero(
                    tag: 'singleImageHero',
                    child: Image.network(
                      imageList.first,
                    ),
                  )
                : Hero(
                    tag: 'multipleImageHero',
                    child: CarouselSlider(
                      items: imageList
                          .map(
                            (item) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              child: Image.network(
                                item,
                                fit: BoxFit.scaleDown,
                                height: Get.mediaQuery.size.height,
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        height: Get.mediaQuery.size.height,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 900),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  )),
        onTap: () {
          Get.back();
        },
      ),
    );
  }
}
