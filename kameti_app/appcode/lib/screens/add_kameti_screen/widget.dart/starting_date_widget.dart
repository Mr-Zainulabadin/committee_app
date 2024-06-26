import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/provider/add_kameti_provider/add_kameti_provider.dart';
import 'package:kameti_app/utils/AppColor.dart';
import 'package:provider/provider.dart';

class StartingDateWidget extends StatelessWidget {
  const StartingDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddKametiProvider>(builder: (_, provider, __) {
      return GestureDetector(
        onTap: () {
          _selectStartDate(context);
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(color: AppColor.offWhite),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColor.grey,
                ),
                child: Center(
                    child: Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                  color: const Color(0xff1C1B1F).withOpacity(.5),
                )),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xffFAF9F6),
                    borderRadius: BorderRadius.circular(4)),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CustomText(
                    text: provider.selectedStartDate == null
                        ? "select stating date"
                        : DateFormat('yyyy-MM-dd')
                            .format(provider.selectedStartDate!),
                    fontSize: 15,
                    fontColor: AppColor.black.withOpacity(.6),
                  ),
                )),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final AddKametiProvider dateProvider =
        Provider.of<AddKametiProvider>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateProvider.selectedStartDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != dateProvider.selectedStartDate) {
      dateProvider.setSelectedStartDate(picked);
    }
  }
}
