import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/providers/auth_provider.dart';
import 'package:news_app/widgets/buttons/app_button.dart';
import 'package:provider/provider.dart';

import '../../helper/app_images.dart';
import '../../helper/fields_validation.dart';
import '../../helper/route_constant.dart';
import '../../widgets/auth_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.sizeOf(context).height * .9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _authProvider.signUpFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Welcome Back",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.sp),
                                ),
                                SizedBox(width: 5),
                                Image.asset(AppImages.waveHand)
                              ],
                            ),
                            Text(
                              "Hello, I guess you are new around here. You can start using the application after sign up",
                              style: TextStyle(fontSize: 15.sp),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            AuthField(
                                hintText: "Username",
                                icon: Icons.person_outline_outlined,
                                controller: _authProvider.usernameController,
                                validator: (v) =>
                                    FieldsValidation.emptyFieldValidation(
                                        _authProvider.usernameController.text)),
                            AuthField(
                                hintText: "Email Address",
                                icon: Icons.email_outlined,
                                controller: _authProvider.emailSignUpController,
                                validator: (v) =>
                                    FieldsValidation.emailFieldValidation(
                                        _authProvider
                                            .emailSignUpController.text)),
                            AuthField(
                              hintText: "Password",
                              icon: Icons.lock_outline,
                              isPassword: true,
                              controller:
                                  _authProvider.passwordSignUpController,
                              validator: (v) =>
                                  FieldsValidation.emptyFieldValidation(
                                      _authProvider
                                          .passwordSignUpController.text),
                            ),
                            AuthField(
                              hintText: "Repeat Password",
                              icon: Icons.lock_outline,
                              isPassword: true,
                              controller: _authProvider.rePasswordController,
                              validator: (v) =>
                                  FieldsValidation.emptyFieldValidation(
                                      _authProvider.rePasswordController.text),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Consumer<AuthProvider>(
                            builder: (context, provider, child) {
                          return Center(
                            child: AppButton(
                                text: "Sign Up",
                                onPressed: provider.isSignUpLoading
                                    ? null
                                    : () {
                                        if (_authProvider
                                            .signUpFormKey.currentState!
                                            .validate()) {
                                          provider.signUpWithEmail(context);
                                        }
                                      }),
                          );
                        })
                      ],
                    ),
                  ),
                  Center(
                    child: RichText(
                        text: TextSpan(
                            text: "Already have an Account?  ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600),
                            children: [
                          TextSpan(
                              text: "Sign In",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  GoRouter.of(context)
                                      .goNamed(RouteConstant.signInScreen);
                                },
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold))
                        ])),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
