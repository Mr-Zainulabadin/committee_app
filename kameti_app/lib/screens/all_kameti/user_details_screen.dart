import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:kameti_app/app_widgets/AppBarWidget.dart";
import "package:kameti_app/app_widgets/custom_text.dart";
import "package:kameti_app/provider/auth_provider/auth_provider.dart";
import "package:kameti_app/screens/kameti_history/widget/kameti_detail_widget.dart";
import "package:kameti_app/utils/AppColor.dart";
import "package:kameti_app/utils/Extensions.dart";
import "package:provider/provider.dart";

class UserDetailsScreen extends StatefulWidget {
  final int selectedIndex;
  const UserDetailsScreen({super.key, required this.selectedIndex});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  List<bool> receivedStatusList = [];
  int kametiCount = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(builder: (_, provider, __) {
      return Scaffold(
        appBar: const CustomAppBar(title: "Kameti Details"),
        body: SingleChildScrollView(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("all_kameti").snapshots(),
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
              final allKametiList =
                  snapshot.data!.docs[0]["all_kameti"][widget.selectedIndex];
              int detailLength =
                  int.parse(allKametiList["total_months"].toString());
              if (receivedStatusList.isEmpty) {
                receivedStatusList =
                    List.generate(detailLength, (index) => false);
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Column(
                  children: [
                    KametiDetailWidget(
                        title: "Kameti Price(each):",
                        value: "Rs. ${allKametiList["perkameti"].toString()}"),
                    6.verSpace,
                    KametiDetailWidget(
                        title: "Total Price:",
                        value:
                            "Rs. ${allKametiList["totalKametiPrice"].toString()}"),
                    6.verSpace,
                    KametiDetailWidget(
                        title: "Total Months:",
                        value: allKametiList["total_months"].toString()),
                    6.verSpace,
                    KametiDetailWidget(
                        title: "Payable Price:",
                        value:
                            "Rs. ${allKametiList["totalKametiPrice"].toString()}"),
                    6.verSpace,
                    KametiDetailWidget(
                        title: "Paid Amount:",
                        value: "Rs. ${allKametiList["perkameti"].toString()}"),
                    6.verSpace,
                    KametiDetailWidget(
                        title: "Remaining Month: ",
                        value:
                            "Rs. ${int.parse(allKametiList["totalKametiPrice"].toString()) - (int.parse(allKametiList["perkameti"].toString()) * kametiCount)}"),
                    6.verSpace,
                    KametiDetailWidget(
                        title: "Starting",
                        value: allKametiList["createdDate"].toString()),
                    20.verSpace,
                    Row(
                      children: [
                        Expanded(
                          child: DataTable(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)),
                              clipBehavior: Clip.antiAlias,
                              headingRowHeight: 45,
                              headingRowColor: WidgetStateProperty.all<Color>(
                                  AppColor.darkRed),
                              columns: [
                                DataColumn(
                                    label: CustomText(
                                  text: "Price",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontColor: Colors.white,
                                )),
                                DataColumn(
                                    label: CustomText(
                                  text: "months",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontColor: Colors.white,
                                )),
                                DataColumn(
                                    label: CustomText(
                                  text: "Status",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontColor: Colors.white,
                                )),
                              ],
                              rows: List.generate(detailLength, (index) {
                                DateTime? currentDate = DateTime.parse(
                                        allKametiList["createdDate"].toString())
                                    .add(Duration(days: index * 30));
                                String formattedDate = DateFormat('yyyy-MM-dd')
                                    .format(currentDate);

                                return DataRow(cells: [
                                  DataCell(Text(
                                      allKametiList["perkameti"].toString())),
                                  DataCell(Text(formattedDate
                                      //allKametiList["startingDate"].toString()
                                      )),
                                  DataCell(GestureDetector(
                                    onTap: () {
                                      if (provider.isAdmin == true) {
                                        setState(() {
                                          receivedStatusList[index] =
                                              !receivedStatusList[index];
                                          if (receivedStatusList[index] ==
                                              true) {
                                            kametiCount++;
                                          } else {
                                            kametiCount--;
                                          } // Toggle the status locally for each row
                                        });
                                      }else{
                                        
                                      }
                                    },
                                    child: CustomText(
                                      text: receivedStatusList[index]
                                          ? "Received"
                                          : "Remaining",
                                      fontColor: receivedStatusList[index]
                                          ? AppColor.green
                                          : Colors.red,
                                    ),
                                  )),
                                ]);
                              })),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
