import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kameti_app/Utils/AppColor.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/MyTextField.dart';
import 'package:kameti_app/app_widgets/custom_button.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/provider/auth_provider/auth_provider.dart';
import 'package:kameti_app/screens/all_kameti/all_kameti_screen.dart';
import 'package:kameti_app/screens/auth_screen/forget_screen.dart';
import 'package:kameti_app/screens/auth_screen/sign_up_screen.dart';
import 'package:kameti_app/screens/dash_board_screen/dash_board_screen.dart';
import 'package:kameti_app/utils/extensions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        title: "Login In",
      ),
      body: Consumer<AuthenticationProvider>(builder: (_, provider, __) {
        return Column(
          children: [
            SizedBox(height: context.mqHeight * .08),
            Container(
              height: 120,
              width: 300,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage(
                        "assets/appIcon.png",
                      ),
                      fit: BoxFit.contain),
                  color: AppColor.grey,
                  shape: BoxShape.circle),
            ),
            //  Image.asset("assets/LoginImage.png"),
            26.verSpace,

            Expanded(
              child: AdminSignUpWidget(
                  onTap: () async {
                    if (provider.isLoading == true) {
                      return;
                    } else {
                      final RegExp emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                      if (emailController.text.isEmpty) {
                        "please enter your email".errorSnack;
                      } else if (!emailRegex
                          .hasMatch(emailController.text.toString())) {
                        'Please enter valid email address'.errorSnack;
                      } else if (passwordController.text.isEmpty) {
                        "please enter your password".errorSnack;
                      } else if (double.parse(
                              passwordController.text.length.toString()) <
                          8) {
                        "password min length is 8".errorSnack;
                      } else {
                        await provider
                            .loginUserWithEmailAndPassword(emailController.text,
                                passwordController.text, context)
                            .then((e) async {
                          bool isAvailable = await provider.checkUserDetails();
                          log(provider.firebaseAuth.currentUser?.uid
                                  .toString() ??
                              "empty");
                          if (isAvailable) {
                            final data = await FirebaseFirestore.instance
                                .collection("users")
                                .doc(provider.firebaseAuth.currentUser?.uid)
                                .get();
                            if (data["isAdmin"] == false) {
                              const AllKametiScreen(isLeading: false).navigate;
                              "Login succussfully".successSnack;
                            } else {
                              const DashboardScreen().navigate;
                              "Login succussfully".successSnack;
                            }
                          }
                        });
                      }
                    }
                  },
                  emailController: emailController,
                  passwordController: passwordController),
            ),
          ],
        );
      }),
    );
  }
}

class AdminSignUpWidget extends StatelessWidget {
  const AdminSignUpWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onTap,
  });
  final VoidCallback onTap;

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<AuthenticationProvider>(builder: (_, provider, __) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
                  child: Column(
                    children: [
                      MyTextField(
                          icon: Icons.person,
                          controller: emailController,
                          hintText: "Enter your email",
                          textInputType: TextInputType.emailAddress),
                      12.verSpace,
                      MyTextField(
                          icon: Icons.lock,
                          controller: passwordController,
                          hintText: "Enter your password",
                          textInputType: TextInputType.text),
                      12.verSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showCupertinoModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    const ForgetPasswordScreen(),
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColor.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple.withOpacity(.5)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: context.mqHeight * .15,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          CustomButton(
                              isLoading: provider.isLoading,
                              onTap: onTap,
                              title: "Login In"),
                        ],
                      ),
                      12.verSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "don't have on account: ",
                            fontColor: AppColor.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          GestureDetector(
                            onTap: () {
                              const SignUPScreen().navigate;
                            },
                            child: CustomText(
                              text: "Sign Up",
                              fontColor: AppColor.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
