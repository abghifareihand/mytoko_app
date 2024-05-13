import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mytoko_app/core/constants/formatter.dart';
import 'package:mytoko_app/presentation/auth/bloc/user/user_bloc.dart';
import 'package:mytoko_app/presentation/home/bloc/products/products_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ScrollController _scrollController = ScrollController();

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      debugPrint('Fetching new data...');
      context.read<ProductsBloc>().add(const ProductsEvent.getProducts());
    }
  }

  @override
  void initState() {
    context.read<ProductsBloc>().add(const ProductsEvent.getProducts());
    context.read<UserBloc>().add(const UserEvent.getUser());
    super.initState();
    _scrollController.addListener(onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue,
                ),
              );
            },
            error: (message) {
              return Center(
                child: Text(message),
              );
            },
            loaded: (productResponse) {
              if (productResponse.isEmpty) {
                return const Center(
                  child: Text('No data Product'),
                );
              }
              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: context.read<ProductsBloc>().hasMore
                    ? productResponse.length + 1
                    : productResponse.length,
                itemBuilder: (context, index) {
                  if (index < productResponse.length) {
                    final product = productResponse[index];
                    return ListTile(
                      title: Text(product.name!),
                      subtitle: Text(priceFormat(product.price)),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: SpinKitFadingCircle(
                          size: 30,
                          color: Colors.redAccent,
                        ),
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
