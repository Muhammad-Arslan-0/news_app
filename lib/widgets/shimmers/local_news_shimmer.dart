import 'package:flutter/material.dart';
import 'package:news_app/widgets/shimmers/shimmer_widget.dart';

class LocalNewsShimmer extends StatelessWidget {
  const LocalNewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                ShimmerWidget(
                  child: Container(
                    height: screenHeight * .3,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: ShimmerWidget(
                      isChild: true,
                      child: Container(
                          height: screenHeight * .06,
                          width: screenWidth * .7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Colors.grey)),
                    ))
              ],
            ),
          );
        });
  }
}
