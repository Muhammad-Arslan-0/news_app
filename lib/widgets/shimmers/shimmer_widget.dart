import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../helper/app_colors.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget child;
  final bool isChild;
  const ShimmerWidget({super.key, required this.child, this.isChild = false});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      period: Duration(seconds: 2),
      gradient: LinearGradient(
          colors: isChild
              ? [ Colors.grey.shade400,AppColors.shimmerBgColor]
              : [AppColors.shimmerBgColor, Colors.white]),
      child: child,
    );
  }
}
