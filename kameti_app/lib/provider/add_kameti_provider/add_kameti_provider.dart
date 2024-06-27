import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kameti_app/utils/extensions.dart';

class AddKametiProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final perKametiController = TextEditingController();
  final totalMonthsController = TextEditingController();
  DateTime? _selectedStartDate;

  DateTime? get selectedStartDate => _selectedStartDate;
  static bool _isLoading = false;

  bool get isLoading => _isLoading;

  DateTime? _selectedEndDate;

  DateTime? get selectedEndDate => _selectedEndDate;

  void setSelectedStartDate(DateTime date) {
    _selectedStartDate = date;
    notifyListeners();
  }

  void setSelectedEndDate(DateTime date) {
    _selectedEndDate = date;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void addKameti() async {
    setLoading(true);
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("all_kameti")
          .doc("all_kameti")
          .get();

      if (snapshot.exists) {
        List<dynamic> allKametiList = snapshot['all_kameti'];

        allKametiList.add({
          "name": nameController.text.toString(),
          "perkameti": perKametiController.text.toString(),
          "total_months": totalMonthsController.text.toString(),
          "totalKametiPrice": int.parse(totalMonthsController.text.toString()) *
              int.parse(perKametiController.text.toString()),
          "createdDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
          "startingDate": DateFormat('yyyy-MM-dd').format(selectedStartDate!),
          "endingDate": DateFormat('yyyy-MM-dd').format(selectedEndDate!),
          "total_user": []
        });
        await FirebaseFirestore.instance
            .collection("all_kameti")
            .doc("all_kameti")
            .update({'all_kameti': allKametiList});
        setLoading(false);
        "Add Kameti SuccessFully".successSnack;
      } else {
        setLoading(false);

        "Document 'all_kameti' does not exist".errorSnack;

        throw Exception("Document 'all_kameti' does not exist.");
      }
    } catch (e) {
      setLoading(false);

      print("Error adding kameti to list: $e");
    }
  }
}
