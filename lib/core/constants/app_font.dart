import 'package:flutter/material.dart';
import 'package:mytoko_app/core/constants/app_color.dart';

class AppFont {
  static TextStyle blackText = const TextStyle(
    fontFamily: 'Poppins',
    color: AppColor.black,
  );
  static TextStyle whiteText = const TextStyle(
    fontFamily: 'Poppins',
    color: AppColor.white,
  );
  static TextStyle greyText = TextStyle(
    fontFamily: 'Poppins',
    color: AppColor.black.withOpacity(0.5),
  );
}

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
