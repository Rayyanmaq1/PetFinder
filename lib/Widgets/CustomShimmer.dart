import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(
        width: 100,
        height: 20,
        color: Colors.white,
      ),
      baseColor: Colors.white,
      highlightColor: Colors.grey[100],
      direction: ShimmerDirection.ltr,
    );
  }
}
