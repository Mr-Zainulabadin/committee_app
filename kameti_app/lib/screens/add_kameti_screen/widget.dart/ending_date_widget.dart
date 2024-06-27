import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kameti_app/app_widgets/custom_text.dart';
import 'package:kameti_app/provider/add_kameti_provider/add_kameti_provider.dart';
import 'package:kameti_app/utils/AppColor.dart';
import 'package:provider/provider.dart';

class EndingDateWidget extends StatelessWidget {
  const EndingDateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AddKametiProvider>(builder: (_, provider, __) {
      return GestureDetector(
        onTap: () {
          _selectEndDate(context);
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
                    text: provider.selectedEndDate == null
                        ? "select ending date"
                        : DateFormat('yyyy-MM-dd')
                            .format(provider.selectedEndDate!),
                    fontColor: AppColor.black.withOpacity(.6),
                    fontSize: 15,
                  ),
                )),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final AddKametiProvider dateProvider =
        Provider.of<AddKametiProvider>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateProvider.selectedEndDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != dateProvider.selectedEndDate) {
      dateProvider.setSelectedEndDate(picked);
    }
  }
}
