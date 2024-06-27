import 'package:flutter/material.dart';
import 'package:kameti_app/app_widgets/MyTextField.dart';
import 'package:kameti_app/app_widgets/custom_button.dart';
import 'package:kameti_app/provider/auth_provider/auth_provider.dart';
import 'package:kameti_app/utils/Extensions.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    return Scaffold(
      body: Consumer<AuthenticationProvider>(builder: (_, provider, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            MyTextField(
                controller: emailController,
                hintText: "Enter your email",
                icon: Icons.person,
                textInputType: TextInputType.emailAddress),
            const Spacer(),
            CustomButton(
                isLoading: provider.isLoading,
                onTap: () async {
                  if (emailController.text.isEmpty) {
                    'Please enter your email'.errorSnack;
                  } else {
                    await provider.resetPassword(emailController.text, context);
                  }
                },
                title: "verify Now"),
            20.verSpace,
          ],
        );
      }),
    );
  }
}
