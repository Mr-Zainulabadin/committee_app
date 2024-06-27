import 'package:flutter/material.dart';
import 'package:kameti_app/Local/PrefManager.dart';
import 'package:kameti_app/Utils/AppColor.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/provider/auth_provider/auth_provider.dart';
import 'package:kameti_app/screens/all_kameti/all_kameti_screen.dart';
import 'package:kameti_app/screens/auth_screen/login_screen.dart';
import 'package:kameti_app/screens/dash_board_screen/dash_board_screen.dart';
import 'package:kameti_app/utils/extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _navigate() async {
    bool isLoggedIn = await PrefManager().isLoggedIn();
    bool isFirstTime = await PrefManager().isFirstTime();
    Future.delayed(const Duration(seconds: 3), () async {
      if (isFirstTime) {
        const LoginScreen().navigate;
       await  PrefManager().setFirstTime();
      } else if (isLoggedIn) {
        final provider = AuthenticationProvider();
        await provider.checkIsAdmin();
        if (provider.isAdmin == true) {
          const DashboardScreen().navigate;
        } else {
          const AllKametiScreen(isLeading: false).navigate;
        }
      } else {
        const LoginScreen().navigate;
      }
    });
  }

  @override
  void initState() {
    _navigate();
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
                          "assets/appIcon.png",
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
