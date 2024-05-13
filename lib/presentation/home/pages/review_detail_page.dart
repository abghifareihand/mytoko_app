import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mytoko_app/core/components/spaces.dart';
import 'package:mytoko_app/core/constants/formatter.dart';
import 'package:mytoko_app/data/models/response/product_detail_response_model.dart';
import 'package:mytoko_app/presentation/home/pages/review_add_page.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_font.dart';
import '../../../core/constants/app_image.dart';

class ReviewDetailPage extends StatelessWidget {
  final int productId;
  final List<Review> review;
  const ReviewDetailPage({
    super.key,
    required this.review,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Review'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: review.isNotEmpty ? review.length : 1,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 2,
            color: AppColor.grey300.withOpacity(0.5),
          );
        },
        itemBuilder: (context, index) {
          // Jika tidak ada review, tampilkan teks
          if (review.isEmpty) {
            return Center(
              child: Text(
                'Belum ada review',
                style: AppFont.blackText.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
            );
          }
          final data = review[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        AppImage.user,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SpaceWidth(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.user!.name!,
                          style: AppFont.blackText.copyWith(
                            fontSize: 14,
                            fontWeight: medium,
                          ),
                        ),
                        RatingBar.builder(
                          initialRating: data.rating!,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 16,
                          ignoreGestures: true,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // Lakukan sesuatu ketika rating diperbarui
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      dateFormat(data.createdAt!),
                      style: AppFont.greyText.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(8),
                Text(
                  data.comment!,
                  style: AppFont.blackText.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReviewAddPage(
                  productId: productId,
                ),
              ),
            );
          },
          child: const Text('Add Review'),
        ),
      ),
    );
  }
}
