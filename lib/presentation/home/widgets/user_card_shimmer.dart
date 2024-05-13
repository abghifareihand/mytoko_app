import 'package:flutter/material.dart';
import 'package:mytoko_app/core/constants/app_color.dart';
import 'package:shimmer/shimmer.dart';

class UserCardShimmer extends StatelessWidget {
  const UserCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.primary.withOpacity(0.3),
      highlightColor: AppColor.primary.withOpacity(0.1),
      child: Container(
        width: 120,
        height: 14,
        color: AppColor.primary,
      ),
    );
  }
}
