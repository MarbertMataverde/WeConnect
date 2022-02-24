import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/page/phone%20view/home/post%20details/image_details.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../widgets/appbar title/appbar_title.dart';

class PostDetails extends StatelessWidget {
  const PostDetails(
      {Key? key, required this.postMedia, required this.postCaption})
      : super(key: key);

  final List postMedia;
  final String postCaption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              MdiIcons.arrowLeft,
              color: Get.isDarkMode
                  ? kButtonColorDarkTheme
                  : kButtonColorLightTheme,
            )),
        centerTitle: true,
        title: const AppBarTitle(
          title: 'Post Details',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: postMedia.length == 1
                  ? Hero(
                      tag: 'singleImageHero',
                      child: GestureDetector(
                        onTap: () => Get.to(ImageDetails(
                          imageList: postMedia,
                        )),
                        child: Image.network(
                          postMedia.first,
                          fit: BoxFit.scaleDown,
                          width: Get.mediaQuery.size.width,
                        ),
                      ),
                    )
                  : CarouselSlider(
                      items: postMedia
                          .map(
                            (item) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              child: Hero(
                                tag: 'multipleImageHero',
                                child: GestureDetector(
                                  onTap: () => Get.to(
                                    () => ImageDetails(
                                      imageList: postMedia,
                                    ),
                                  ),
                                  child: Image.network(
                                    item,
                                    fit: BoxFit.scaleDown,
                                    width: Get.mediaQuery.size.width,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        height: Get.mediaQuery.size.height * .5,
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
            ),
            Padding(
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Get.textTheme.titleMedium!.fontSize,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    postCaption,
                    style: TextStyle(
                      fontSize: Get.textTheme.titleMedium!.fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
