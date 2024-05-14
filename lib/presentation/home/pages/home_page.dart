import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytoko_app/core/components/spaces.dart';
import 'package:mytoko_app/core/constants/app_color.dart';
import 'package:mytoko_app/core/constants/app_font.dart';
import 'package:mytoko_app/core/extensions/screen.dart';
import 'package:mytoko_app/presentation/home/bloc/cart/cart_bloc.dart';
import 'package:mytoko_app/presentation/home/pages/cart_page.dart';
import 'package:mytoko_app/presentation/home/pages/search_page.dart';
import 'package:mytoko_app/presentation/home/widgets/banner_slider.dart';
import 'package:mytoko_app/presentation/home/widgets/product_card.dart';
import 'package:mytoko_app/presentation/home/widgets/product_card_shimmer.dart';
import 'package:mytoko_app/presentation/home/widgets/user_card_shimmer.dart';

import '../../auth/bloc/user/user_bloc.dart';
import '../bloc/favorite/favorite_bloc.dart';
import '../bloc/products/products_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ProductsBloc>().add(const ProductsEvent.getProducts());
    context.read<CartBloc>().add(const CartEvent.getCart());
    context.read<UserBloc>().add(const UserEvent.getUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: AppColor.primary,
        onRefresh: () async {
          context.read<ProductsBloc>().add(const ProductsEvent.getProducts());
          await Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  /// Header
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    height: context.screenHeight * 0.25,
                    decoration: const BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// User
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome',
                                    style: AppFont.whiteText.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                  BlocBuilder<UserBloc, UserState>(
                                    builder: (context, state) {
                                      return state.maybeWhen(
                                        orElse: () {
                                          return const UserCardShimmer();
                                        },
                                        loading: () {
                                          return const UserCardShimmer();
                                        },
                                        loaded: (userResponse) {
                                          return Text(
                                            userResponse.data!.name!,
                                            style: AppFont.whiteText.copyWith(
                                              fontWeight: medium,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CartPage(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 6, right: 6),
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: AppColor.white.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.shopping_cart,
                                        color: AppColor.white,
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
                                                style:
                                                    AppFont.whiteText.copyWith(
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
                              const SpaceWidth(8),
                              Container(
                                margin: const EdgeInsets.only(top: 6, right: 6),
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColor.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.notifications,
                                  color: AppColor.white,
                                ),
                              ),
                            ],
                          ),
                          const SpaceHeight(32),

                          /// Search
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchProductPage(),
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      color: AppColor.grey400,
                                    ),
                                    const SpaceWidth(8.0),
                                    Text(
                                      'Search',
                                      style: AppFont.greyText.copyWith(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )

                          // TextFormField(
                          //   onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         const SearchProductPage(),
                          //   ),
                          // );
                          //   },
                          //   decoration: InputDecoration(
                          //     hintText: 'Search',
                          //     filled: true,
                          //     fillColor: AppColor.white,
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //       borderSide: BorderSide.none,
                          //     ),
                          //     contentPadding:
                          //         const EdgeInsets.symmetric(horizontal: 16.0),
                          //     prefixIcon: const Icon(
                          //       Icons.search,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const BannerSlider(),
                ],
              ),
            ),
            BlocListener<FavoriteBloc, FavoriteState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  loaded: (favoriteResponse) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text(favoriteResponse.message!),
                        backgroundColor: favoriteResponse.isFavorite!
                            ? Colors.green
                            : Colors.red,
                      ),
                    );
                    context
                        .read<ProductsBloc>()
                        .add(const ProductsEvent.getProducts());
                  },
                );
              },
              child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const ProductCardShimmer();
                    },
                    error: (message) {
                      return Center(
                        child: Text(message),
                      );
                    },
                    loaded: (productResponse) {
                      if (productResponse.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Center(
                            child: Text('No data Product'),
                          ),
                        );
                      }
                      return SliverPadding(
                        padding: const EdgeInsets.all(20),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.76,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            childCount: productResponse.length,
                            (BuildContext context, int index) {
                              final product = productResponse[index];
                              return ProductCard(product: product);
                            },
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
      ),
    );
  }
}
