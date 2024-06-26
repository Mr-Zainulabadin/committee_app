import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/MyTextField.dart';
import 'package:kameti_app/app_widgets/custom_button.dart';
import 'package:kameti_app/provider/auth_provider/auth_provider.dart';

import 'package:kameti_app/utils/Extensions.dart';
import 'package:provider/provider.dart';

class UserAddInKametiScreen extends StatelessWidget {
  final int selectedIndex;
  const UserAddInKametiScreen({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    final cityController = TextEditingController();
    final nameController = TextEditingController();
    final cnicController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(title: "Add User"),
      body: Consumer<AuthenticationProvider>(builder: (_, provider, __) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            children: [
              Column(children: [
                MyTextField(
                  controller: nameController,
                  hintText: "Enter your Name",
                  icon: Icons.person,
                  textInputType: TextInputType.name,
                ),
                8.verSpace,
                MyTextField(
                  controller: phoneController,
                  hintText: "Enter your Phone Number",
                  icon: Icons.phone,
                  textInputType: TextInputType.number,
                ),
                8.verSpace,
                MyTextField(
                  controller: addressController,
                  hintText: "Enter your Address",
                  icon: Icons.location_on_outlined,
                  textInputType: TextInputType.number,
                ),
                8.verSpace,
                MyTextField(
                  controller: cityController,
                  hintText: "Enter your city",
                  icon: Icons.location_city,
                  textInputType: TextInputType.number,
                ),
              ]),
              const Spacer(),
              CustomButton(
                  onTap: () async {
                    if (nameController.text.isEmpty) {
                      "Please enter your name".errorSnack;
                    } else if (phoneController.text.isEmpty) {
                      "Please enter your phone number".errorSnack;
                    } else if (cnicController.text.isNotEmpty) {
                      "Please enter your cnic number".errorSnack;
                    } else if (addressController.text.isEmpty) {
                      "Please enter your Address".errorSnack;
                    } else if (cityController.text.isEmpty) {
                      "Please enter your city Name".errorSnack;
                    } else {
                      try {
                        final DocumentSnapshot snapshot =
                            await FirebaseFirestore.instance
                                .collection("all_kameti")
                                .doc("all_kameti")
                                .get();
                        if (snapshot.exists) {
                          List<dynamic> allKametiList = snapshot['all_kameti'];
                          Map<String, dynamic> newUser = {
                            "cnic": cnicController.text.toString(),
                            "city": cityController.text.toString(),
                            "Address": addressController.text.toString(),
                            "email": provider.firebaseAuth.currentUser?.email
                                .toString(),
                            "ispay": false,
                            "name": nameController.text.toString(),
                            "phone": phoneController.text.toString(),
                          };

                          if (allKametiList.isNotEmpty) {
                            List<dynamic> totalUserList =
                                allKametiList[selectedIndex]['total_user'];
                            totalUserList.add(newUser);
                          }
                          await FirebaseFirestore.instance
                              .collection("all_kameti")
                              .doc("all_kameti")
                              .update({'all_kameti': allKametiList});
                          "User added successfully".successSnack;
                        } else {
                          "Document 'all_kameti' does not exist".errorSnack();
                          throw Exception(
                              "Document 'all_kameti' does not exist.");
                        }
                      } catch (e) {
                        print("Error adding user to kameti: $e");
                      }
                    }
                  },
                  title: "Add Now")
            ],
          ),
        );
      }),
    );
  }
}
