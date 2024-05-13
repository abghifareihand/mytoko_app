import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytoko_app/presentation/home/bloc/favorite/favorite_bloc.dart';
import 'package:mytoko_app/presentation/home/bloc/product_search/product_search_bloc.dart';
import 'presentation/auth/pages/login_page.dart';
import 'presentation/auth/bloc/user/user_bloc.dart';
import 'presentation/home/bloc/products/products_bloc.dart';
import 'presentation/home/bloc/product_detail/product_detail_bloc.dart';
import 'presentation/home/bloc/review/review_bloc.dart';
import 'presentation/home/pages/home_page.dart';

import 'data/datasources/auth_local_datasource.dart';
import 'presentation/auth/bloc/login/login_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(),
        ),
         BlocProvider(
          create: (context) => ProductSearchBloc(),
        ),
        BlocProvider(
          create: (context) => ProductDetailBloc(),
        ),
        BlocProvider(
          create: (context) => ReviewBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
        ),
        home: FutureBuilder<bool>(
          future: AuthLocalDatasource().isLogin(),
          builder: (context, snapshot) {
            debugPrint("isLogin: ${snapshot.data}");
            if (snapshot.data != null && snapshot.data!) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
