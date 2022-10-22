import 'package:bloodgency/models/request_model.dart';
import 'package:flutter/cupertino.dart';

class BloodRequestProvider extends ChangeNotifier {
  List<DonationRequestModel> _requests = [];

  List<DonationRequestModel> get getRequest {
    return _requests;
  }

  void addRequest(Map<String, dynamic> request) {
    _requests.add(DonationRequestModel.fromMap(request));
    notifyListeners();
  }

  void addToFirst(Map<String, dynamic> request) {
    _requests.insert(0, DonationRequestModel.fromMap(request));
    notifyListeners();
  }

  void setRequest(List<dynamic> listRequests) {
    _requests = [];
    listRequests.forEach((e) {
      if (e['total'] != e['terkumpul']) {
        _requests.add(DonationRequestModel.fromMap(e));
      }
    });
    notifyListeners();
  }
}
