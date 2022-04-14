import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:linkwell/linkwell.dart';
import 'package:sizer/sizer.dart';

import '../../../../widgets/appbar/build_appbar.dart';
import 'image_details.dart';

class PostDetails extends StatelessWidget {
  const PostDetails(
      {Key? key, required this.postMedia, required this.postCaption})
      : super(key: key);

  final List postMedia;
  final String postCaption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Post Details',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Iconsax.arrow_square_left,
            color: Theme.of(context).iconTheme.color,
          ),
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
                          width: MediaQuery.of(context).size.width,
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
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * .5,
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
                  const Text(
                    'Description',
                    textScaleFactor: 1.3,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  LinkWell(
                    postCaption,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                    linkStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
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
