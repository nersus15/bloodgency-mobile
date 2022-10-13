import 'package:bloodgency/models/request_model.dart';
import 'package:flutter/cupertino.dart';

class BloodRequestProvider extends ChangeNotifier {
  List<DonationRequestModel> requests = [];

  List<DonationRequestModel> get getRequest {
    return [];
  }

  void addRequest(Map<String, dynamic> request) {
    requests.add(DonationRequestModel.fromMap(request));
    notifyListeners();
  }

  void setRequest(List<Map<String, dynamic>> listRequests) {
    requests = [];
    listRequests.map((e) => requests.add(DonationRequestModel.fromMap(e)));
    notifyListeners();
  }
}
