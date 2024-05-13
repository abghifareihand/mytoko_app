import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytoko_app/core/components/loading.dart';
import 'package:mytoko_app/core/components/spaces.dart';
import 'package:mytoko_app/core/constants/app_color.dart';
import 'package:mytoko_app/core/constants/app_font.dart';
import 'package:mytoko_app/presentation/home/pages/home_page.dart';

import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/models/request/login_request_model.dart';
import '../bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SpaceHeight(50),

          /// Email
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: AppColor.grey200,
                ),
              ),
            ),
            style: AppFont.blackText.copyWith(
              fontWeight: medium,
            ),
          ),
          const SpaceHeight(20),

          /// Password
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: AppColor.grey200,
                ),
              ),
            ),
            style: AppFont.blackText.copyWith(
              fontWeight: medium,
            ),
          ),
          const SpaceHeight(30),

          /// Button
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final loginRequest = LoginRequestModel(
                  email: emailController.text,
                  password: passwordController.text,
                );
                context.read<LoginBloc>().add(LoginEvent.login(loginRequest));
              },
              child: BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    loaded: (authResponse) async {
                      await AuthLocalDatasource().saveAuthData(authResponse);
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(authResponse.message!),
                            backgroundColor: Colors.green,
                          ),
                        );
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
                      return Text(
                        'Login',
                        style: AppFont.whiteText.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      );
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
    );
  }
}
