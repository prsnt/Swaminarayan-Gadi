import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/contact_us_model.dart';
import 'package:flutter/material.dart';

class ContactUsNotifier with ChangeNotifier {
  ContactUsModel? contactUsModel;
  bool loading = false;

  Future<void> fetchContactUsData() async {
    loading = true;
    contactUsModel = (await getContactUsData())!;
    loading = false;

    notifyListeners();
  }
}
