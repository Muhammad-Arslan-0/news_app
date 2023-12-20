import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const AppButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return onPressed == null
        ? Container(
            width: screenWidth * .5,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                shape: BoxShape.circle,
                color: Colors.red),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child:
                  Center(child: CircularProgressIndicator(color: Colors.white)),
            ))
        : SizedBox(
            width: screenWidth,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    splashFactory: InkSplash.splashFactory,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: onPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(text,
                      style: TextStyle(color: Colors.white, fontSize: 17.sp)),
                )),
          );
  }
}
