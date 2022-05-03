import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../../widgets/appbar/build_appbar.dart';

class Gallery extends StatelessWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(
          context: context,
          title: 'Gallery',
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
        body: Padding(
          padding: EdgeInsets.all(5.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildGalleryFacade(context: context),
                SizedBox(
                  height: 5.h,
                ),
                _buildGalleryFacilities(context: context),
              ],
            ),
          ),
        ));
  }
}

Widget _buildGalleryFacade({required BuildContext context}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildTitle(context: context, title: 'URSB Facade'),
      _buildImage(context: context, imageList: [
        'assets/gallery/facade.jpg',
      ]),
      const Divider(),
      const Text(
        'The marvelous façade of URS Binangonan exudes majesty and strength. The four pillars framing its central feature projects the feeling of stability for all its denizens. It was the first structure built as a part of the then Rizal State College Binangonan Campus through the efforts of its leading benefactors; Governor Casimiro “Ito” Ynares, Mayor Cesar Ynares and Congressman Gilberto Duavit.',
        textAlign: TextAlign.justify,
      ),
    ],
  );
}

Widget _buildGalleryFacilities({required BuildContext context}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildTitle(
        context: context,
        title: 'URSB Facilities',
      ),
      _buildImage(context: context, imageList: [
        'assets/gallery/comlab.jpg',
        'assets/gallery/functionhall.jpg',
        'assets/gallery/avr.jpg',
        'assets/gallery/library.jpg',
      ]),
      const Divider(),
      const Text(
        'To better facilitate the learning process, URSB maintains a conducive learning environment by providing educational facilities such as Audio Visual Room, Internet center, Computer laboratories, Typing Rooms, Libraries and Function Halls. To keep pace with the fast-evolving technology, URSB also strive to update its instructional equipment in all academic classrooms.',
        textAlign: TextAlign.justify,
      ),
    ],
  );
}

Widget _buildTitle({
  required String title,
  required BuildContext context,
}) {
  return Text(
    title,
    textScaleFactor: 1.7,
    style: TextStyle(
      color: Theme.of(context).primaryColor,
    ),
  );
}

Widget _buildImage({
  required List<String> imageList,
  required BuildContext context,
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
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        );
}
