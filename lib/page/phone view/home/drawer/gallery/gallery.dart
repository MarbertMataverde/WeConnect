import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../widgets/appbar/appbar_title.dart';

class Gallery extends StatelessWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const AppBarTitle(title: 'Gallery'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(5.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildGalleryFacade(),
                SizedBox(
                  height: 5.h,
                ),
                _buildGalleryFacilities(),
              ],
            ),
          ),
        ));
  }
}

Widget _buildGalleryFacade() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildTitle(title: 'URSB Facade'),
      _buildImage(imageList: [
        'assets/gallery/facade.jpg',
      ]),
      const Divider(),
      const Text(
          'The marvelous façade of URS Binangonan exudes majesty and strength. The four pillars framing its central feature projects the feeling of stability for all its denizens. It was the first structure built as a part of the then Rizal State College Binangonan Campus through the efforts of its leading benefactors; Governor Casimiro “Ito” Ynares, Mayor Cesar Ynares and Congressman Gilberto Duavit.'),
    ],
  );
}

Widget _buildGalleryFacilities() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildTitle(title: 'URSB Facilities'),
      _buildImage(imageList: [
        'assets/gallery/comlab.jpg',
        'assets/gallery/functionhall.jpg',
        'assets/gallery/avr.jpg',
        'assets/gallery/library.jpg',
      ]),
      const Divider(),
      const Text(
          'To better facilitate the learning process, URSB maintains a conducive learning environment by providing educational facilities such as Audio Visual Room, Internet center, Computer laboratories, Typing Rooms, Libraries and Function Halls. To keep pace with the fast-evolving technology, URSB also strive to update its instructional equipment in all academic classrooms.'),
    ],
  );
}

Widget _buildTitle({
  required String title,
}) {
  return Text(
    title,
    textScaleFactor: 1.5,
    style: TextStyle(
      color: Get.theme.primaryColor,
    ),
  );
}

Widget _buildImage({
  required List<String> imageList,
}) {
  return imageList.length == 1
      ? Image.asset(imageList.first)
      : CarouselSlider(
          items: imageList
              .map(
                (item) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  child: Image.asset(
                    item,
                    fit: BoxFit.cover,
                    width: Get.mediaQuery.size.width,
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 900),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        );
}
