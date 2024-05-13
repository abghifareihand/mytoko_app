import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mytoko_app/core/components/loading.dart';
import 'package:mytoko_app/core/components/spaces.dart';
import 'package:mytoko_app/data/models/request/review_request_model.dart';
import 'package:mytoko_app/presentation/home/bloc/review/review_bloc.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_font.dart';
import '../bloc/product_detail/product_detail_bloc.dart';

class ReviewAddPage extends StatefulWidget {
  final int productId;
  const ReviewAddPage({
    super.key,
    required this.productId,
  });

  @override
  State<ReviewAddPage> createState() => _ReviewAddPageState();
}

class _ReviewAddPageState extends State<ReviewAddPage> {
  final TextEditingController commentController = TextEditingController();
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nilai Produk'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Text(
                'Kualitas Produk',
                style: AppFont.blackText.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
              const SpaceWidth(8),
              RatingBar.builder(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 28,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  setState(() {
                    rating = value;
                  });
                },
              ),
            ],
          ),
          const SpaceHeight(8),
          TextFormField(
            controller: commentController,
            decoration: InputDecoration(
              hintText: 'Bagikan penilainmu terhadap produk ini..',
              hintStyle: AppFont.greyText.copyWith(
                fontSize: 14,
                fontWeight: regular,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: AppColor.grey200,
                ),
              ),
            ),
            maxLines: 4,
            style: AppFont.blackText.copyWith(
              fontWeight: medium,
            ),
          ),
          const SpaceHeight(16),
          ElevatedButton(
            onPressed: () {
              final reviewRequest = ReviewRequestModel(
                productId: widget.productId,
                rating: rating,
                comment: commentController.text,
              );
              context
                  .read<ReviewBloc>()
                  .add(ReviewEvent.addReview(reviewRequest));
            },
            child: BlocConsumer<ReviewBloc, ReviewState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  loaded: (reviewResponse) async {
                    if (context.mounted) {
                      context.read<ProductDetailBloc>().add(
                          ProductDetailEvent.getProductDetail(
                              widget.productId));

                      Navigator.pop(context);
                    }
                  },
                  error: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const Text('Kirim Review');
                  },
                  loading: () {
                    return const LoadingSpinkit();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
