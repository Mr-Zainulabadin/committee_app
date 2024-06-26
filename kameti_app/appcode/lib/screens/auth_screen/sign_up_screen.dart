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
import 'package:kameti_app/screens/auth_screen/login_screen.dart';
import 'package:kameti_app/screens/dash_board_screen/dash_board_screen.dart';
import 'package:kameti_app/utils/extensions.dart';
import 'package:provider/provider.dart';

class SignUPScreen extends StatelessWidget {
  const SignUPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final cnicController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        title: "Sign In",
      ),
      body: Consumer<AuthenticationProvider>(builder: (_, provider, __) {
        return Column(
          children: [
            SizedBox(
              height: context.mqHeight * .03,
            ),
            Container(
              height: context.mqHeight * .17,
              width: context.mqWidth * .7,
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
                  final RegExp emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (nameController.text.isEmpty) {
                    'Please enter your Name'.errorSnack;
                  } else if (emailController.text.isEmpty) {
                    'Please enter your email'.errorSnack;
                  } else if (!emailRegex
                      .hasMatch(emailController.text.toString())) {
                    'Please enter valid email address'.errorSnack;
                  } else if (phoneController.text.isEmpty) {
                    'Please enter your email'.errorSnack;
                  } else if (cnicController.text.isEmpty) {
                    'Please enter your cnic number'.errorSnack;
                  } else if (passwordController.text.isEmpty) {
                    "Please enter your password".errorSnack;
                  } else if (confirmPasswordController.text.length < 8) {
                    "Please enter your confirm password".errorSnack;
                  } else {
                    await provider
                        .createUserWithEmailAndPassword(emailController.text,
                            passwordController.text, context)
                        .then((value) async {
                      bool isAvailable = await provider.checkUserDetails();
                      if (isAvailable) {
                        log("The user details are $isAvailable");
                        "user already existed".successSnack;
                        const LoginScreen().navigate;
                      } else if (provider
                          .firebaseAuth.currentUser!.emailVerified) {
                        log("The user details are $isAvailable");
                        "email already in use".successSnack;
                        const LoginScreen().navigate;
                      } else {
                        bool success = await provider.sendData(
                            emailController.text.toString(),
                            nameController.text.toString(),
                            phoneController.text.toString(),
                            cnicController.text.toString());
                        if (success) {
                          final data = await FirebaseFirestore.instance
                              .collection("users")
                              .doc(provider.firebaseAuth.currentUser?.uid)
                              .get();
                          if (data["isAdmin"] == false) {
                            const AllKametiScreen(isLeading: false).navigate;
                            "sign up successfully".successSnack;
                          } else {
                            const DashboardScreen().navigate;
                            "sign up successfully".successSnack;
                          }
                        }
                      }
                    });
                  }
                },
                nameController: nameController,
                emailController: emailController,
                phoneController: phoneController,
                cnicController: cnicController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              ),
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
    required this.confirmPasswordController,
    required this.emailController,
    required this.passwordController,
    required this.onTap,
    required this.nameController,
    required this.phoneController,
    required this.cnicController,
  });

  final TextEditingController confirmPasswordController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController cnicController;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(builder: (_, provider, __) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyTextField(
                    icon: Icons.person,
                    controller: nameController,
                    hintText: "Enter Your Name",
                    textInputType: TextInputType.name),
                8.verSpace,
                MyTextField(
                    icon: Icons.person,
                    controller: emailController,
                    hintText: "Enter Your Email",
                    textInputType: TextInputType.emailAddress),
                8.verSpace,
                MyTextField(
                    icon: Icons.phone,
                    controller: phoneController,
                    hintText: "Enter Your Phone Number",
                    textInputType: TextInputType.phone),
                8.verSpace,
                MyTextField(
                    icon: Icons.credit_card_sharp,
                    controller: cnicController,
                    hintText: "Enter Your cnic Number",
                    textInputType: TextInputType.number),
                8.verSpace,
                MyTextField(
                    icon: Icons.lock,
                    controller: passwordController,
                    hintText: "Enter Your Password",
                    textInputType: TextInputType.text),
                8.verSpace,
                MyTextField(
                    icon: Icons.lock,
                    controller: confirmPasswordController,
                    hintText: "Enter Your Confirm Password",
                    textInputType: TextInputType.text),
                SizedBox(
                  height: context.mqHeight * .08,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: context.mqHeight * .15,
                  child: Column(
                    children: [
                      CustomButton(
                          isLoading: provider.isLoading,
                          onTap: onTap,
                          title: "Sign Up"),
                      12.verSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "you have an account: ",
                            fontColor: AppColor.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          GestureDetector(
                            onTap: () {
                              const LoginScreen().navigate;
                            },
                            child: CustomText(
                              text: "Login",
                              fontColor: AppColor.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
