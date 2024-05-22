import 'package:flutter/material.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/screens/all_kameti/User_add_in_kameti.dart';
import 'package:kameti_app/screens/all_kameti/kameti_all_user.dart';
import 'package:kameti_app/screens/all_kameti/user_details_screen.dart';
import 'package:kameti_app/utils/AppColor.dart';
import 'package:kameti_app/utils/Extensions.dart';

class AllKametiScreen extends StatelessWidget {
  final bool isLeading;
  const AllKametiScreen({super.key, required this.isLeading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.darkBlue,
          onPressed: () {
            const UserAddInKametiScreen().navigate;
          },
          child: Center(
            child: Icon(
              Icons.add,
              color: AppColor.white,
            ),
          ),
        ),
        appBar: CustomAppBar(
          title: "All Kameti",
          isLeading: isLeading,
        ),
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
                    const KametiAllUserScreen().navigate;
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColor.black.withOpacity(.5),
                  ),
                  subtitle: CustomText(
                    text: "Duration: 5 months",
                    fontColor: AppColor.black.withOpacity(.5),
                  ),
                  title: CustomText(
                    text: "Zain ALi",
                    fontColor: AppColor.black,
                  ),
                ),
              );
            },
          ),
        ));
  }
}
