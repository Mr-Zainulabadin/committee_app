import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kameti_app/Utils/AppColor.dart';
import 'package:kameti_app/app_widgets/AppBarWidget.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/screens/kameti_history/widget/bottom_sheet_content.dart';
import 'package:kameti_app/utils/extensions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
        title: 'History',
      ),
      body: Padding(
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
                    final formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
                    return Container(
                      decoration: BoxDecoration(color: AppColor.grey, borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                          onTap: () {
                            showCupertinoModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      height: context.mqHeight * .4,
                                      child: const BottomSheetContent(),
                                    ));
                          },
                          textColor: AppColor.black,
                          title: CustomText(text: "Coder", fontSize: 15, fontColor: AppColor.black),
                          subtitle: CustomText(text: formattedDate, fontSize: 15, fontColor: AppColor.black.withOpacity(.5)),
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
    );
  }
}

//   void _showCryptoBottomSheet(BuildContext context, int index) {
//     showModalBottomSheet(
//       constraints: BoxConstraints(maxHeight: context.mqHeight * 0.9),
//       isScrollControlled: true,
//       backgroundColor: AppColor.offWhite,
//       context: context,
//       builder: (BuildContext context) {
//         return 
//       },
//     );
//   }
// }
