import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/app_colors.dart';

class AuthSocialButton extends StatelessWidget {
  final String logo;
  final String text;
  final Function()? onTap;
  final bool isOutlined;
  const AuthSocialButton(
      {super.key,
      required this.logo,
      required this.text,
      required this.onTap,
      this.isOutlined = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: screenWidth,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                splashFactory: InkSplash.splashFactory,
                foregroundColor: isOutlined ? Colors.white : Colors.red,
                backgroundColor:
                    isOutlined ? Colors.white : AppColors.authFieldBgColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    side: isOutlined
                        ? BorderSide(
                            color: AppColors.authFieldBgColor, width: 2)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(10))),
            onPressed: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: screenWidth * .06,
                      width: screenWidth * .06,
                      child: Image.asset(
                        logo,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: screenWidth * .6,
                      child: Text(
                        text,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
