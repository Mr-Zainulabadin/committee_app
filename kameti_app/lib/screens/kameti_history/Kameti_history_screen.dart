import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kameti_app/Utils/AppColor.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/screens/kameti_history/widget/kameti_detail_widget.dart';
import 'package:kameti_app/utils/extensions.dart';
import 'package:provider/provider.dart';

class KametiHistoryScreen extends StatefulWidget {
  const KametiHistoryScreen({super.key});

  @override
  State<KametiHistoryScreen> createState() => _KametiHistoryScreenState();
}

class _KametiHistoryScreenState extends State<KametiHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        // onTrailingClick: () {},
        title: 'History',
        //  isTrailing: true,
        // trailingIcon: const Icon(
        //
        // CupertinoIcons.search,
        // )
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: Colors.white,
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              12.verSpace,
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: CustomText(
                      text: 'Kameti History',
                      fontSize: 18,
                      fontColor: AppColor.black,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              const CupertinoActivityIndicator(
                color: Colors.white,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      final parsedDate = DateTime.now();
                      final formattedDate =
                          DateFormat('yyyy-MM-dd').format(parsedDate);
                      return Container(
                        decoration: BoxDecoration(
                            color: AppColor.grey,
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                            onTap: () {
                              _showCryptoBottomSheet(context, index);
                            },
                            textColor: AppColor.black,
                            title: CustomText(
                                text: "Coder",
                                fontSize: 15,
                                fontColor: AppColor.black),
                            subtitle: CustomText(
                                text: formattedDate,
                                fontSize: 15,
                                fontColor: AppColor.black.withOpacity(.5)),
                            trailing: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.black,
                            )),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    // await Provider.of<InvestmentProvider>(context, listen: false).fetchInvestmentHistory();

    await Future.delayed(const Duration(microseconds: 1500));
  }

  void _showCryptoBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      constraints: BoxConstraints(maxHeight: context.mqHeight * 0.9),
      isScrollControlled: true,
      backgroundColor: AppColor.offWhite,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.offWhite,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              10.verSpace,
              Text(
                "Kameti Details",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              10.verSpace,
              const KametiDetailWidget(title: "Name", value: "Coder"),
              const KametiDetailWidget(
                  title: "Per Kameti Price", value: "2000"),
              const KametiDetailWidget(
                  title: "Kameti Total Price", value: "24000"),
              const KametiDetailWidget(title: "Total Months", value: "12"),
              const KametiDetailWidget(
                  title: "Starting Date", value: "19/12/2023"),
              const KametiDetailWidget(
                  title: "Ending Date", value: "19/12/2024"),
            ],
          ),
        );
      },
    );
  }
}
