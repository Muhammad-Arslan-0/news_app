import 'package:flutter/material.dart';
import 'package:news_app/widgets/shimmers/shimmer_widget.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShimmerWidget(
                child: Container(
                  height: screenHeight * .04,
                  width: screenWidth * .7,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            ShimmerWidget(
              child: GridView.builder(
                  itemCount: 10,
                  primary: true,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return Container(
                      height: screenWidth * .4,
                      width: screenWidth * .4,
                      decoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
