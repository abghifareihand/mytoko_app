import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mytoko_app/core/components/loading.dart';
import 'package:mytoko_app/core/constants/app_image.dart';
import 'package:mytoko_app/data/models/request/add_cart_request_model.dart';
import 'package:mytoko_app/data/models/request/favorite_request_model.dart';
import 'package:mytoko_app/presentation/home/bloc/add_cart/add_cart_bloc.dart';
import 'package:mytoko_app/presentation/home/bloc/cart/cart_bloc.dart';
import 'package:mytoko_app/presentation/home/bloc/favorite/favorite_bloc.dart';
import 'package:mytoko_app/presentation/home/bloc/products/products_bloc.dart';
import 'package:mytoko_app/presentation/home/pages/cart_page.dart';
import 'package:mytoko_app/presentation/home/pages/review_add_page.dart';
import 'package:mytoko_app/presentation/home/pages/review_detail_page.dart';
import 'package:mytoko_app/presentation/home/widgets/product_detail_shimmer.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_font.dart';
import '../bloc/product_detail/product_detail_bloc.dart';

class DetailPage extends StatefulWidget {
  final int productId;
  const DetailPage({
    super.key,
    required this.productId,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    context
        .read<ProductDetailBloc>()
        .add(ProductDetailEvent.getProductDetail(widget.productId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const ProductDetailShimmer();
            },
            loading: () {
              return const ProductDetailShimmer();
            },
            loaded: (productDetailResponse) {
              final product = productDetailResponse.data;
              return ListView(
                children: [
                  /// Image no slider
                  Stack(
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          AppImage.place,
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
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
                              onTap: () {
                                Navigator.pop(context);
                              },
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
                            Row(
                              children: [
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
                                              color:
                                                  Colors.grey.withOpacity(0.3),
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
                                      child: BlocBuilder<CartBloc, CartState>(
                                        builder: (context, state) {
                                          return state.maybeWhen(
                                            orElse: () {
                                              return const SizedBox();
                                            },
                                            loaded: (cartResponse) {
                                              return CircleAvatar(
                                                radius: 10,
                                                backgroundColor: AppColor.red,
                                                child: Text(
                                                  '${cartResponse.totalQuantity}',
                                                  style: AppFont.whiteText
                                                      .copyWith(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SpaceWidth(8.0),
                                InkWell(
                                  onTap: () {
                                    final favoriteRequest =
                                        FavoriteRequestModel(
                                            productId: product.id!);
                                    context.read<FavoriteBloc>().add(
                                        FavoriteEvent.doFavorite(
                                            favoriteRequest));
                                  },
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
                                    child: BlocListener<FavoriteBloc,
                                        FavoriteState>(
                                      listener: (context, state) {
                                        state.maybeWhen(
                                          orElse: () {},
                                          loaded: (favoriteResponse) {
                                            context
                                                .read<ProductDetailBloc>()
                                                .add(ProductDetailEvent
                                                    .getProductDetail(
                                                        widget.productId));
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.favorite,
                                        color: product!.isFavorite!
                                            ? Colors.red
                                            : Colors.grey,
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
                        Text(
                          product!.name!,
                          style: AppFont.blackText.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SpaceHeight(16),
                        Text(
                          'Description',
                          style: AppFont.blackText.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                        const SpaceHeight(8),
                        Text(
                          product.description!,
                          style: AppFont.blackText.copyWith(
                            fontSize: 14,
                            fontWeight: regular,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SpaceHeight(24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reviews',
                              style: AppFont.blackText.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewDetailPage(
                                      productId: product.id!,
                                      review: product.reviews!,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'View All ${productDetailResponse.data!.reviews!.length}',
                                style: AppFont.greyText.copyWith(
                                  fontSize: 12,
                                  fontWeight: medium,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemCount: product.reviews!.isEmpty
                              ? 1 // Jika tidak ada review, tampilkan satu item untuk menampilkan pesan "Belum ada review"
                              : product.reviews!.length >= 2
                                  ? 2 // Jika ada dua atau lebih review, tampilkan maksimal dua review
                                  : 1, // Jika hanya ada satu review, tampilkan satu review saja
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              height: 2,
                              color: AppColor.grey300.withOpacity(0.5),
                            );
                          },
                          itemBuilder: (context, index) {
                            // Jika tidak ada review, tampilkan teks
                            if (product.reviews!.isEmpty) {
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
                            final review = product.reviews![index];
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            review.user!.name!,
                                            style: AppFont.blackText.copyWith(
                                              fontSize: 14,
                                              fontWeight: medium,
                                            ),
                                          ),
                                          RatingBar.builder(
                                            initialRating: review.rating!,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 16,
                                            ignoreGestures: true,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              // Lakukan sesuatu ketika rating diperbarui
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SpaceHeight(8),
                                  Text(
                                    review.comment!,
                                    style: AppFont.blackText.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColor.white,
                  foregroundColor: AppColor.primary,
                  side: const BorderSide(color: AppColor.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewAddPage(
                        productId: widget.productId,
                      ),
                    ),
                  );
                },
                child: const Text('Add Review'),
              ),
            ),
            const SpaceWidth(12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  final addCartRequest = AddCartRequestModel(
                    productId: widget.productId,
                  );
                  context
                      .read<AddCartBloc>()
                      .add(AddCartEvent.addToCart(addCartRequest));
                },
                child: BlocConsumer<AddCartBloc, AddCartState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      loaded: (addCartResponse) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(addCartResponse.message!),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartPage(),
                          ),
                        );
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
                        return const Text('Add to Cart');
                      },
                      loading: () {
                        return const LoadingSpinkit();
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
