import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal :5.0,vertical: 5.0),
      child: SizedBox(
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade400,
          child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15)
                ),
                height: 70,
                
          )
      )),
    );
  }
}