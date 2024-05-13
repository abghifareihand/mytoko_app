import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mytoko_app/core/extensions/screen.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_image.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<String> banners = [
    AppImage.banner1,
    AppImage.banner2,
    AppImage.banner1,
    AppImage.banner2,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: banners.length,
            itemBuilder: (context, index, realIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  banners[index],
                  width: context.screenWidth,
                  fit: BoxFit.cover,
                ),
              );
            },
            options: CarouselOptions(
              height: 150,
              autoPlay: true,
              // enableInfiniteScroll: false,
              autoPlayAnimationDuration: const Duration(seconds: 2),
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          const SpaceHeight(16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: banners.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: _current == entry.key ? 20.0 : 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? AppColor.grey300
                              : AppColor.primary)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
