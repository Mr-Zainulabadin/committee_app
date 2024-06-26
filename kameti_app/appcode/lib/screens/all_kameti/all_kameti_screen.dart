import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/screens/all_kameti/User_add_in_kameti.dart';
import 'package:kameti_app/screens/all_kameti/kameti_all_user.dart';
import 'package:kameti_app/utils/AppColor.dart';
import 'package:kameti_app/utils/Extensions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AllKametiScreen extends StatefulWidget {
  final bool isLeading;
  const AllKametiScreen({super.key, required this.isLeading});

  @override
  State<AllKametiScreen> createState() => _AllKametiScreenState();
}

class _AllKametiScreenState extends State<AllKametiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "All Kameti",
        isLeading: widget.isLeading,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          children: [
            20.verSpace,
            CustomText(
              text:
                  "If you're interested in joining any committee, just check their advertisement and apply accordingly.",
              fontSize: 13,
              fontColor: AppColor.black,
              textAlignment: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
            12.verSpace,
            StreamBuilder(
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
                final allKametiList = snapshot.data!.docs[0]["all_kameti"];
                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: allKametiList.length,
                    itemBuilder: (context, index) {
                      final kameti = allKametiList[index];
                      return GestureDetector(
                        onTap: () {
                          KametiAllUserScreen(
                            selectedIndex: index,
                          ).navigate;
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 15),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColor.offWhite,
                            border: Border.all(
                                color: AppColor.black.withOpacity(.3)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              deleteItemFromFirestore(
                                                  "all_kameti", index);
                                            },
                                            child: const Center(
                                              child: Icon(
                                                CupertinoIcons.delete,
                                                size: 16,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          15.horSpace,
                                          GestureDetector(
                                            onTap: () {
                                              // updateItemInFirestore(
                                              //     "all_kameti", index, {
                                              //   "name": "zain khan",
                                              // });
                                            },
                                            child: Center(
                                              child: Icon(
                                                Icons.edit,
                                                size: 16,
                                                color: AppColor.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      8.verSpace,
                                      Row(
                                        children: [
                                          CustomText(
                                            text: "Name :",
                                            fontColor: AppColor.black,
                                          ),
                                          12.horSpace,
                                          CustomText(
                                            text: kameti['name'],
                                            fontColor:
                                                AppColor.black.withOpacity(.5),
                                          ),
                                        ],
                                      ),
                                      8.verSpace,
                                      Row(
                                        children: [
                                          CustomText(
                                            text: "Duration :",
                                            fontColor: AppColor.black,
                                          ),
                                          12.horSpace,
                                          CustomText(
                                            text:
                                                "${kameti['total_months']} Months",
                                            fontColor:
                                                AppColor.black.withOpacity(.5),
                                          ),
                                        ],
                                      ),
                                      8.verSpace,
                                      Row(
                                        children: [
                                          CustomText(
                                            text: "Starting Date :",
                                            fontColor: AppColor.black,
                                          ),
                                          12.horSpace,
                                          CustomText(
                                            // text: DateFormat('yyyy-MM-dd HH:mm:ss')
                                            //     .format(kameti['createdDate']),

                                            text: "${kameti['createdDate']}",
                                            fontColor:
                                                AppColor.black.withOpacity(.5),
                                          ),
                                        ],
                                      ),
                                      8.verSpace,
                                      Row(
                                        children: [
                                          CustomText(
                                            text: "Expairy :",
                                            fontColor: AppColor.black,
                                          ),
                                          12.horSpace,
                                          CustomText(
                                            text: "${kameti['endingDate']}",
                                            fontColor:
                                                AppColor.black.withOpacity(.5),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showCupertinoModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            UserAddInKametiScreen(
                                          selectedIndex: index,
                                        ),
                                      );
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
                                            text: "Add user",
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "Per Months :",
                                    fontColor: AppColor.red,
                                  ),
                                  12.horSpace,
                                  CustomText(
                                    text: "${kameti['perkameti']}",
                                    fontColor: AppColor.red,
                                  ),
                                ],
                              ),
                            ],
                          ),
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

  Future<void> updateItemInFirestore(String documentId, int indexToUpdate,
      Map<String, dynamic> updatedData) async {
    try {
      // Get the document reference
      var docRef =
          FirebaseFirestore.instance.collection("all_kameti").doc(documentId);

      // Get the current snapshot of the document
      DocumentSnapshot docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        print('Document does not exist');
        return;
      }

      // Get the current array (total_user) from the document data
      List<dynamic> totalUserArray = docSnapshot["all_kameti"];

      // Update the item at the specified index
      if (indexToUpdate >= 0 && indexToUpdate < totalUserArray.length) {
        totalUserArray[indexToUpdate] = updatedData;

        // Update the document with the modified array
        await docRef.update({
          'all_kameti': totalUserArray,
        });

        setState(() {
          // Optionally, update your UI state if necessary
        });

        'kameti updated successfully'.successSnack;
      } else {
        print('Index out of range or invalid');
      }
    } catch (e) {
      'Error updating item: $e'.errorSnack;
    }
  }

  // Function to delete a kameti
  Future<void> deleteItemFromFirestore(
      String documentId, int indexToDelete) async {
    try {
      // Get the document reference
      var docRef =
          FirebaseFirestore.instance.collection("all_kameti").doc(documentId);

      // Get the current snapshot of the document
      DocumentSnapshot docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        print('Document does not exist');
        return;
      }

      // Get the current array (total_user) from the document data
      List<dynamic> totalUserArray = docSnapshot["all_kameti"];

      // Remove the item at the specified index
      if (indexToDelete >= 0 && indexToDelete < totalUserArray.length) {
        totalUserArray.removeAt(indexToDelete);

        // Update the document with the modified array
        await docRef.update({
          'all_kameti': totalUserArray,
        });
        setState(() {});

        'kameti deleted successfully'.successSnack;
      } else {
        print('Index out of range or invalid');
      }
    } catch (e) {
      'Error deleting item: $e'.errorSnack;
    }
  }
}
