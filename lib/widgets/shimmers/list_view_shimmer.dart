import 'package:flutter/material.dart';
import 'package:news_app/widgets/shimmers/shimmer_widget.dart';

class ListViewShimmer extends StatelessWidget {
  const ListViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return ListView.builder(
        itemCount: 10,
        primary: false,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            child: ListTile(
              leading: ShimmerWidget(child: CircleAvatar()),
              title: ShimmerWidget(
                child: Container(
                  height: screenHeight * .03,
                  width: screenWidth * .7,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              subtitle: ShimmerWidget(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    height: screenHeight * .05,
                    width: screenWidth * .6,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
