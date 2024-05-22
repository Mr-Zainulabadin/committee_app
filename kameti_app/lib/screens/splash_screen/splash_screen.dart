import 'package:flutter/material.dart';
import 'package:kameti_app/Utils/AppColor.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';

import 'package:kameti_app/screens/auth_screen/login_screen.dart';
import 'package:kameti_app/utils/extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      return const LoginScreen().navigate;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: context.mqHeight * .15,
              ),
              Container(
                height: 120,
                width: 300,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(
                          "assets/logoIcon.png",
                        ),
                        fit: BoxFit.contain),
                    color: AppColor.grey,
                    shape: BoxShape.circle),
              ),
              10.verSpace,
              CustomText(
                text: "KAMETI APP",
                fontSize: 32,
                fontColor: AppColor.black,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: context.mqHeight * .35,
              ),
              CustomText(
                text: "KAMETI APP",
                fontSize: 16,
                fontColor: AppColor.black,
                fontWeight: FontWeight.w600,
              ),
              2.verSpace,
              CustomText(
                text: "join Hands, Share Dreams, Connecting Communities!",
                fontSize: 11,
                fontColor: AppColor.black,
                fontWeight: FontWeight.w500,
              )
            ],
          ),
        ),
      ),
    );
  }
}
