import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytoko_app/core/constants/app_color.dart';
import 'package:mytoko_app/core/constants/app_font.dart';
import 'package:mytoko_app/core/constants/formatter.dart';
import 'package:mytoko_app/data/models/request/favorite_request_model.dart';
import 'package:mytoko_app/data/models/response/products_response_model.dart';
import 'package:mytoko_app/presentation/home/bloc/favorite/favorite_bloc.dart';
import 'package:mytoko_app/presentation/home/pages/detail_page.dart';
import '../../../core/constants/app_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(productId: product.id!),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                /// Image product
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    AppImage.product,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                /// Favorite
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColor.white,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: () {
                        final favoriteRequest =
                            FavoriteRequestModel(productId: product.id!);
                        context
                            .read<FavoriteBloc>()
                            .add(FavoriteEvent.doFavorite(favoriteRequest));
                      },
                      child: Icon(
                        Icons.favorite,
                        color: product.isFavorite! ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// Title product
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!,
                    style: AppFont.blackText.copyWith(
                      fontWeight: medium,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    priceFormat(product.price),
                    style: AppFont.blackText.copyWith(
                      fontWeight: medium,
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
