import 'package:flutter/material.dart';
import 'package:mytoko_app/core/constants/app_color.dart';
import 'package:mytoko_app/core/constants/app_font.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailShimmer extends StatelessWidget {

 const ProductDetailShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        /// Image slider
        // ImageSliderProduct(
        //   imageUrls: widget.product.galleries
        //       .map((gallery) => gallery.imageUrl)
        //       .toList(),
        //   controller: _controller,
        // ),

        /// Image no slider
        Stack(
          children: [
            // Shimmer effect for image
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 300,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: 18,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Back
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  /// Cart
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(right: 4),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.shopping_bag,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColor.red,
                          child: Text(
                            '4',
                            style: AppFont.whiteText.copyWith(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer effect for product name
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // Shimmer effect for description title
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 100,
                  height: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              // Shimmer effect for description
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
