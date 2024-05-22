import 'package:flutter/material.dart';
import 'package:kameti_app/app_widgets/MyTextField.dart';
import 'package:kameti_app/app_widgets/custom_button.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/utils/AppColor.dart';
import 'package:kameti_app/utils/Extensions.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: "Forget Password",
            fontColor: AppColor.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          MyTextField(
              controller: emailController,
              hintText: "Enter your password",
              icon: Icons.person,
              textInputType: TextInputType.emailAddress),
          CustomButton(
              onTap: () {
                if (emailController.text.isEmpty) {
                  "Please Enter your email".errorSnack;
                } else {
                  "Send Password to your email".successSnack;
                }
              },
              title: "verify Now")
        ],
      ),
    );
  }
}
