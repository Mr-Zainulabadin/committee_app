import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/screens/kameti_history/widget/kameti_detail_widget.dart';
import 'package:kameti_app/utils/AppColor.dart';
import 'package:kameti_app/utils/Extensions.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  bool isPay = false;
  bool isPay2 = false;
  bool isPay3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Kameti Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          children: [
            const kametiDetailWidget(title: "Kameti Price(each):", value: "Rs. 2000"),
            6.verSpace,
            const kametiDetailWidget(title: "Your Kameti(s):", value: "x19"),
            6.verSpace,
            const kametiDetailWidget(title: "Total Price:", value: "Rs. 24000"),
            6.verSpace,
            const kametiDetailWidget(title: "Total Months:", value: "24"),
            6.verSpace,
            const kametiDetailWidget(title: "Payable Price:", value: "Rs. 20000"),
            6.verSpace,
            const kametiDetailWidget(title: "Paid Amount:", value: "Rs. 0"),
            6.verSpace,
            const kametiDetailWidget(title: "Remaining Month: ", value: "Rs. 540000"),
            6.verSpace,
            const kametiDetailWidget(title: "Starting", value: "DD/MM/YYYY"),
            20.verSpace,
            Row(
              children: [
                Expanded(
                  child: DataTable(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                      clipBehavior: Clip.antiAlias,
                      headingRowHeight: 45,
                      headingRowColor: MaterialStateProperty.all<Color>(AppColor.darkBlue),
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
                      rows: [
                        DataRow(cells: [
                          const DataCell(Text("2000")),
                          const DataCell(Text("02/0424")),
                          DataCell(GestureDetector(
                              onTap: () {
                                setState(() => isPay = isPay);
                              },
                              child: Text(
                                isPay ? "Payed" : "Pay",
                                style: TextStyle(color: isPay ? Colors.green : Colors.red),
                              ))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text("2000")),
                          const DataCell(Text("02/0424")),
                          DataCell(GestureDetector(
                              onTap: () {
                                setState(() => isPay2 = !isPay2);
                              },
                              child: Text(
                                isPay2 ? "Payed" : "Pay",
                                style: TextStyle(color: isPay2 ? Colors.green : Colors.red),
                              ))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text("2000")),
                          const DataCell(Text("02/0424")),
                          DataCell(GestureDetector(
                              onTap: () {
                                setState(() => isPay3 = !isPay3);
                              },
                              child: Text(
                                isPay3 ? "Payed" : "Pay",
                                style: TextStyle(color: isPay3 ? Colors.green : Colors.red),
                              ))),
                        ]),
                      ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
