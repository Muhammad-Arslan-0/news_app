import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/helper/app_images.dart';
import 'package:news_app/providers/auth_provider.dart';
import 'package:news_app/widgets/buttons/app_button.dart';
import 'package:news_app/widgets/auth_field.dart';
import 'package:news_app/widgets/buttons/auth_social_button.dart';
import 'package:provider/provider.dart';

import '../../helper/fields_validation.dart';
import '../../helper/route_constant.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: authProvider.signInFormKey,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.sizeOf(context).height * .9,
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
                                  fontWeight: FontWeight.bold, fontSize: 25.sp),
                            ),
                            SizedBox(width: 5),
                            Image.asset(AppImages.waveHand)
                          ],
                        ),
                        Text(
                          "I am happy to see you again. You can continue where you left of by logging in",
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        AuthField(
                            hintText: "Email Address",
                            icon: Icons.email_outlined,
                            controller: authProvider.emailSignInController,
                            validator: (v) =>
                                FieldsValidation.emailFieldValidation(
                                    authProvider.emailSignInController.text)),
                        AuthField(
                          hintText: "Password",
                          icon: Icons.lock_outline,
                          isPassword: true,
                          controller: authProvider.passwordSignInController,
                          validator: (v) =>
                              FieldsValidation.emptyFieldValidation(
                                  authProvider.passwordSignInController.text),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(fontSize: 15.sp),
                            ))
                      ],
                    ),
                    Consumer<AuthProvider>(
                        builder: (context, provider, child) {
                      return Center(
                        child: AppButton(
                          text: "Sign In",
                          onPressed: provider.isSignInLoading
                              ? null
                              : () {
                                  if (authProvider.signInFormKey.currentState!.validate()) {
                                    provider.signInWithEmail(context);
                                  }
                                },
                        ),
                      );
                    }),
                    Center(child: Text("or", style: TextStyle(fontSize: 20.sp))),
                    Column(
                      children: [
                        AuthSocialButton(
                            logo: AppImages.googleLogo,
                            text: "Sign In with Google",
                            isOutlined: true,
                            onTap: () {
                              authProvider.signInWithGoogle(context);
                            }),
                        AuthSocialButton(
                            logo: AppImages.fbLogo,
                            text: "Sign In with Facebook",
                            isOutlined: true,
                            onTap: () {}),
                      ],
                    ),
                    Center(
                      child: RichText(
                          text: TextSpan(
                              text: "Don't have an Account?  ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600),
                              children: [
                            TextSpan(
                                text: "Sign Up",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    GoRouter.of(context)
                                        .pushNamed(RouteConstant.signUpScreen);
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
      ),
    );
  }
}
