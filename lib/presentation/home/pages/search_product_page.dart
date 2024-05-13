import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytoko_app/core/components/loading.dart';
import 'package:mytoko_app/core/constants/app_color.dart';
import 'package:mytoko_app/core/constants/formatter.dart';
import 'package:mytoko_app/presentation/home/bloc/favorite/favorite_bloc.dart';
import 'package:mytoko_app/presentation/home/bloc/product_search/product_search_bloc.dart';
import 'package:mytoko_app/presentation/home/bloc/products/products_bloc.dart';
import 'package:mytoko_app/presentation/home/widgets/product_card.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({
    super.key,
  });

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();

  @override
  void initState() {
    context.read<ProductSearchBloc>().add(const ProductSearchEvent.started());
    searchFocus.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: AppColor.primary),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                height: 42,
                child: Material(
                  borderRadius: BorderRadius.circular(7),
                  elevation: 1,
                  child: TextFormField(
                    focusNode: searchFocus,
                    controller: searchController,
                    onFieldSubmitted: (value) {
                      debugPrint('Kamu cari : $value');
                      context
                          .read<ProductSearchBloc>()
                          .add(ProductSearchEvent.getProductSearch(value));
                    },
                    decoration: InputDecoration(
                      prefixIcon: InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.only(
                            left: 6,
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 23,
                          ),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(top: 10),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocListener<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            loaded: (favoriteResponse) {
              context.read<ProductSearchBloc>().add(
                  ProductSearchEvent.getProductSearch(searchController.text));
            },
          );
        },
        child: BlocBuilder<ProductSearchBloc, ProductSearchState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const SizedBox();
              },
              loading: () {
                return const LoadingSpinkit();
              },
              loaded: (productResponse) {
                if (productResponse.isEmpty) {
                  return const Center(
                    child: Text('Product yg dicari tidak ada'),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: productResponse.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.76,
                  ),
                  itemBuilder: (context, index) {
                    final product = productResponse[index];
                    return ProductCard(product: product);
                  },
                );
              },
              error: (message) {
                return Center(
                  child: Text(message),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
