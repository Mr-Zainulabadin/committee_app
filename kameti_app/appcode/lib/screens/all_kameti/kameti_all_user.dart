import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/provider/auth_provider/auth_provider.dart';
import 'package:kameti_app/screens/all_kameti/user_details_screen.dart';
import 'package:kameti_app/utils/AppColor.dart';
import 'package:kameti_app/utils/Extensions.dart';
import 'package:share_plus/share_plus.dart';

class KametiAllUserScreen extends StatelessWidget {
  final int selectedIndex;
  const KametiAllUserScreen({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Kameti All User"),
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("all_kameti")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      color: AppColor.white,
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No kameti available."),
                  );
                }
                List<dynamic> allUserList = snapshot.data!.docs[0]["all_kameti"]
                    [selectedIndex]["total_user"];
                return ListView.builder(
                  itemCount: allUserList.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data!.docs[0]["all_kameti"]
                        [selectedIndex]["total_user"][index];
                    final kametiItem =
                        snapshot.data!.docs[0]["all_kameti"][selectedIndex];
                    return GestureDetector(
                      onTap: () {
                        UserDetailsScreen(
                          selectedIndex: selectedIndex,
                        ).navigate;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColor.offWhite,
                            border: Border.all(
                                color: AppColor.black.withOpacity(.3))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Name : ${item["name"].toString()}",
                                      fontColor: AppColor.black,
                                    ),
                                    3.verSpace,
                                    CustomText(
                                      text:
                                          "Phone Number : ${item["phone"].toString()}",
                                      fontColor: AppColor.black,
                                    ),
                                    3.verSpace,
                                    CustomText(
                                      text:
                                          "Unpaid Kameti : ${(int.parse(kametiItem["totalKametiPrice"].toString()) - int.parse(kametiItem["perkameti"].toString())) / int.parse(kametiItem["perkameti"].toString())}",
                                      fontColor: AppColor.black,
                                    ),
                                  ],
                                ),
                                AuthenticationProvider().isAdmin
                                    ? GestureDetector(
                                        onTap: () async {
                                          final result = await Share.share(
                                              'Please Pay your kameti on Time :  https://example.com');

                                          if (result.status ==
                                              ShareResultStatus.success) {
                                            "Send notification Message Successfully"
                                                .successSnack;
                                          }
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: AppColor.black
                                                    .withOpacity(.3)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CustomText(
                                                text: "Notify user",
                                                fontSize: 8,
                                                fontColor: AppColor.black,
                                              ),
                                              Icon(
                                                CupertinoIcons.bell,
                                                size: 16,
                                                color: AppColor.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Divider(
                                color: AppColor.red,
                                thickness: 1,
                              ),
                            ),
                            4.verSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "This Month Status",
                                  fontColor: AppColor.green,
                                ),
                                CustomText(
                                  text: "Received",
                                  fontColor: AppColor.green,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
        ));
  }
}
