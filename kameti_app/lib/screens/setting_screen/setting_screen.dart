import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kameti_app/Local/PrefManager.dart';
import 'package:kameti_app/Utils/AppColor.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/provider/auth_provider/auth_provider.dart';
import 'package:kameti_app/screens/splash_screen/splash_screen.dart';
import 'package:kameti_app/utils/Extensions.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Setting"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Consumer<AuthenticationProvider>(builder: (_, provider, __) {
          return Column(
            children: [
              12.verSpace,
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                height: 65,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Login With:",
                      fontSize: 14,
                      fontColor: AppColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: provider.firebaseAuth.currentUser!.email.toString(),
                      fontSize: 12,
                      fontColor: AppColor.black.withOpacity(.6),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              12.verSpace,
              const SettingTileWidget(
                  title: "Edit Profile", icon: Icons.person_2_outlined),
              const SettingTileWidget(
                  title: "All Records", icon: Icons.list_outlined),
              const SettingTileWidget(
                  title: "Notifications",
                  icon: Icons.notifications_none_outlined),
              SettingTileWidget(
                  onTap: () async {
                    final result =
                        await Share.share('Link:  https://example.com');

                    if (result.status == ShareResultStatus.success) {
                      "Send Successfully".successSnack;
                    }
                  },
                  title: "Share",
                  icon: Icons.share_outlined),
              const SettingTileWidget(
                  title: "Support", icon: CupertinoIcons.mail),
              // const SettingTileWidget(
              //     title: "Privacy Policy", icon: Icons.star_outline_outlined),
              const SettingTileWidget(
                  title: "Rate Us", icon: Icons.star_outline_outlined),
              SettingTileWidget(
                  onTap: () async {
                    PrefManager().signOut();
                    const SplashScreen().navigate;
                    await AuthenticationProvider().signOut();
                  },
                  title: "Logout",
                  icon: Icons.logout_outlined),
            ],
          );
        }),
      ),
    );
  }
}

class SettingTileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  const SettingTileWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppColor.black,
                  size: 26,
                ),
                10.horSpace,
                CustomText(
                  text: title,
                  fontSize: 14,
                  fontColor: AppColor.black.withOpacity(.6),
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
            Divider(
              thickness: .3,
              color: AppColor.black.withOpacity(.5),
            )
          ],
        ),
      ),
    );
  }
}
