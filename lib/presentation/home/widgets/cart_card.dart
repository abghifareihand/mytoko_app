import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytoko_app/core/components/spaces.dart';
import 'package:mytoko_app/core/constants/app_color.dart';
import 'package:mytoko_app/core/constants/app_font.dart';
import 'package:mytoko_app/core/constants/app_image.dart';
import 'package:mytoko_app/core/constants/formatter.dart';
import 'package:mytoko_app/data/models/request/add_cart_request_model.dart';
import 'package:mytoko_app/data/models/response/cart_response_model.dart';
import 'package:mytoko_app/presentation/home/bloc/add_cart/add_cart_bloc.dart';
import 'package:mytoko_app/presentation/home/bloc/cart/cart_bloc.dart';
import 'package:mytoko_app/presentation/home/bloc/remove_cart/remove_cart_bloc.dart';

class CartCard extends StatelessWidget {
  final Cart cart;

  const CartCard({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCartBloc, AddCartState>(
      listener: (context, state) {
        // Update UI jika penambahan ke keranjang berhasil
        state.maybeWhen(
          orElse: () {},
          loaded: (addCartResponse) {
            context.read<CartBloc>().add(const CartEvent.getCart());
          },
        );
      },
      child: BlocListener<RemoveCartBloc, RemoveCartState>(
        listener: (context, state) {
          // Update UI jika penghapusan dari keranjang berhasil
          state.maybeWhen(
            orElse: () {},
            loaded: (removeCartResponse) {
              context.read<CartBloc>().add(const CartEvent.getCart());
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  AppImage.product,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SpaceWidth(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cart.product!.name!,
                      style: AppFont.blackText.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            priceFormat(cart.product!.price! * cart.quantity!),
                            style: AppFont.blackText.copyWith(
                              fontWeight: medium,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                context.read<RemoveCartBloc>().add(
                                    RemoveCartEvent.removeFromCart(cart.id!));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColor.primary,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  cart.quantity == 1
                                      ? Icons.delete
                                      : Icons.remove,
                                  size: 20,
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 32.0,
                              child: Center(
                                child: Text(
                                  cart.quantity.toString(),
                                  style: AppFont.blackText.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                context.read<AddCartBloc>().add(
                                    AddCartEvent.addToCart(AddCartRequestModel(
                                        productId: cart.product!.id!)));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColor.primary,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 20,
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
