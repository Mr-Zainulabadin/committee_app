import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/utils/AppColor.dart';
import 'package:kameti_app/utils/Extensions.dart';

class AddUserInKametiScreen extends StatefulWidget {
  final int selectedIndex;
  const AddUserInKametiScreen({super.key, required this.selectedIndex});

  @override
  State<AddUserInKametiScreen> createState() => _AllKametiScreenState();
}

class _AllKametiScreenState extends State<AddUserInKametiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "All User",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          children: [
            20.verSpace,
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
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
                    child: Text("No Users available."),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = snapshot.data!.docs[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.offWhite,
                          border:
                              Border.all(color: AppColor.black.withOpacity(.3)),
                        ),
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () async {
                                      try {
                                        final DocumentSnapshot snapshot =
                                            await FirebaseFirestore.instance
                                                .collection("all_kameti")
                                                .doc("all_kameti")
                                                .get();
                                        if (snapshot.exists) {
                                          List<dynamic> allKametiList =
                                              snapshot['all_kameti'];
                                          Map<String, dynamic> newUser = {
                                            "cnic":
                                                item["cnicNumber"].toString(),
                                            "userId": item["userId"].toString(),
                                            "email": item["email"].toString(),
                                            "ispay": false,
                                            "name": item["FullName"].toString(),
                                            "phone":
                                                item["phoneNumber"].toString(),
                                          };

                                          if (allKametiList.isNotEmpty) {
                                            List<dynamic> totalUserList =
                                                allKametiList[
                                                        widget.selectedIndex]
                                                    ['total_user'];
                                            totalUserList.add(newUser);
                                          }
                                          await FirebaseFirestore.instance
                                              .collection("all_kameti")
                                              .doc("all_kameti")
                                              .update({
                                            'all_kameti': allKametiList
                                          });
                                          "User added successfully"
                                              .successSnack;
                                        } else {
                                          "Document 'all_kameti' does not exist"
                                              .errorSnack();
                                          throw Exception(
                                              "Document 'all_kameti' does not exist.");
                                        }
                                      } catch (e) {
                                        print(
                                            "Error adding user to kameti: $e");
                                      }
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color:
                                                AppColor.black.withOpacity(.3)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomText(
                                            text: "ADD",
                                            fontSize: 8,
                                            fontColor: AppColor.black,
                                          ),
                                          Icon(
                                            CupertinoIcons.person_add,
                                            size: 16,
                                            color: AppColor.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                      text: "Name :",
                                      fontColor: AppColor.black,
                                    ),
                                    12.horSpace,
                                    CustomText(
                                      text: item['FullName'],
                                      fontColor: AppColor.black.withOpacity(.5),
                                    ),
                                  ],
                                ),
                                8.verSpace,
                                Row(
                                  children: [
                                    CustomText(
                                      text: "Email :",
                                      fontColor: AppColor.black,
                                    ),
                                    12.horSpace,
                                    CustomText(
                                      text: "${item['email']}",
                                      fontColor: AppColor.black.withOpacity(.5),
                                    ),
                                  ],
                                ),
                                8.verSpace,
                                Row(
                                  children: [
                                    CustomText(
                                      text: "User ID :",
                                      fontColor: AppColor.black,
                                    ),
                                    12.horSpace,
                                    CustomText(
                                      // text: DateFormat('yyyy-MM-dd HH:mm:ss')
                                      //     .format(kameti['createdDate']),

                                      text: "${item['userId']}",
                                      fontColor: AppColor.black.withOpacity(.5),
                                    ),
                                  ],
                                ),
                                8.verSpace,
                                Row(
                                  children: [
                                    CustomText(
                                      text: "Phone :",
                                      fontColor: AppColor.black,
                                    ),
                                    12.horSpace,
                                    CustomText(
                                      text: "${item['phoneNumber']}",
                                      fontColor: AppColor.black.withOpacity(.5),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
