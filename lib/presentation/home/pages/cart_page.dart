import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytoko_app/core/components/loading.dart';
import 'package:mytoko_app/core/constants/app_font.dart';
import 'package:mytoko_app/presentation/home/bloc/cart/cart_bloc.dart';
import 'package:mytoko_app/presentation/home/widgets/cart_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<CartBloc>().add(const CartEvent.getCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const LoadingSpinkit();
            },
            loaded: (cartResponse) {
              if (cartResponse.data!.isEmpty) {
                return Center(
                  child: Text(
                    'Cart Empty',
                    style: AppFont.blackText.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: cartResponse.data!.length,
                itemBuilder: (context, index) {
                  final cart = cartResponse.data![index];
                  return CartCard(cart: cart);
                },
              );
            },
          );
        },
      ),
    );
  }
}
