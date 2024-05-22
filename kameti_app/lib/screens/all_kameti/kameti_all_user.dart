import 'package:flutter/material.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/screens/all_kameti/user_details_screen.dart';
import 'package:kameti_app/utils/AppColor.dart';
import 'package:kameti_app/utils/Extensions.dart';

class KametiAllUserScreen extends StatelessWidget {
  const KametiAllUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Kameti All User"),
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.offWhite,
                    border: Border.all(color: AppColor.black.withOpacity(.3))),
                child: ListTile(
                  onTap: () {
                    const UserDetailsScreen().navigate;
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColor.black.withOpacity(.5),
                  ),
                  subtitle: CustomText(
                    text: "Months Name: pay/not pay",
                    fontColor: AppColor.black.withOpacity(.5),
                  ),
                  title: CustomText(
                    text: "coder",
                    fontColor: AppColor.black,
                  ),
                ),
              );
            },
          ),
        ));
  }
}
