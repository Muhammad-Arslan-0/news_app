import 'package:flutter/material.dart';

import '../helper/app_colors.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;

  final String? Function(String?)? validator;
  const AuthField(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.controller,
      this.validator,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.authFieldBgColor,
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon),
              SizedBox(width: 15),
              Expanded(
                  child: TextFormField(
                controller: controller,
                validator: validator,
                obscureText: isPassword,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: hintText),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
