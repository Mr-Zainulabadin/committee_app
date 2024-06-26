import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kameti_app/screens/setting_screen/setting_screen.dart';
import 'package:kameti_app/screens/splash_screen/splash_screen.dart';
import 'package:kameti_app/utils/extensions.dart';

import '../Utils/AppColor.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isLeading;
  const CustomAppBar({super.key, this.isLeading = true, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        isLeading
            ? Container()
            : IconButton(
                onPressed: () async {
                  //  await PrefManager().isSignOut();
                  const SettingScreen().navigate;
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ))
      ],
      leading: isLeading
          ? InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            )
          : null,
      centerTitle: true,
      backgroundColor: AppColor.grey,
      title: CustomText(
        text: title,
        fontColor: AppColor.black,
        fontSize: 16,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
