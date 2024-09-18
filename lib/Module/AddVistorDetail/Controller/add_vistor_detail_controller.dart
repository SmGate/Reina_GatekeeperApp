import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/AddVistorDetail/Model/add_visitor_detail_model.dart';
import 'package:gatekeeper/Module/AddVistorDetail/service/add_visitor_detail_service.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import '../../../Routes/set_routes.dart';
import '../../Login/Model/User.dart';
import '../Model/Resident.dart';

class AddVisitorDetailController extends GetxController {
  final formKey = new GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController searchAddressController = TextEditingController();
  TextEditingController guestVehicleNo = TextEditingController();

  List<String> searchedAddressList = [];
  File? imageFile;
  RxBool isLoading = false.obs;
  var errorAddingVisitor = "";
  var addVisitorDetailModel = AddVisitorDetailModel();

  DateTime currentDateTime = DateTime.now();
  String? currentDate;
  String? currentTime;

  var data = Get.arguments;
  late final User userdata;

  String? gateKeeperDropDownValue;
  String? visitorTypeDropDownValue = 'Guest';
  String? visitingTypeDropDownValue = 'House/Apartment Visit';

  List<String> visitorTypesList = ['Guest', 'Delivery', 'Cab', 'Visiting Help'];
  List<String> visitingTypesList = ['House/Apartment Visit', 'Society Visit'];

  Resident? resident;
  List<Resident> li = [];

  setVisitingType(value) {
    visitingTypeDropDownValue = value;
    update();
  }

  setVisitorType(value) {
    visitorTypeDropDownValue = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    userdata = data;
    getResident(userdata.subadminid!, userdata.bearerToken!);
  }

  final focus = FocusNode();

  Future<List<Resident>> getResident(int subadminid, String token) async {
    final response = await Http.get(
      Uri.parse(Api.searchResident + "/" + subadminid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print(data);
      li = await (data['data'] as List)
          .map(
            (e) => Resident(
                id: e['id'],
                houseaddress: e['houseaddress'],
                residentid: e['residentid']),
          )
          .toList();
      li;

      return li;
    } else {
      throw Exception('Error');
    }
  }

  // Future addVisitorDetailApi({
  //   required String token,
  //   required int gatekeeperid,
  //   required int societyid,
  //   required int subadminid,
  //   String? houseaddress,
  //   required String visitortype,
  //   required String name,
  //   required String cnic,
  //   required String mobileno,
  //   required String vechileno,
  //   required String arrivaldate,
  //   required String arrivaltime,
  // }) async {
  //   isLoading.value = true;
  //   update();
  //   final response = await Http.post(
  //     Uri.parse(Api.addvistordetail),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': "Bearer $token"
  //     },
  //     body: jsonEncode(<String, dynamic>{
  //       "gatekeeperid": gatekeeperid,
  //       "societyid": societyid,
  //       "subadminid": subadminid,
  //       "houseaddress": houseaddress,
  //       "visitortype": visitortype,
  //       "name": name,
  //       "cnic": cnic,
  //       "mobileno": mobileno,
  //       "vechileno": vechileno,
  //       "arrivaldate": arrivaldate,
  //       "arrivaltime": arrivaltime,
  //       "checkoutdate": arrivaldate,
  //       "checkouttime": arrivaltime,
  //       "status": 0,
  //       "statusdescription": "checkin",
  //     }),
  //   );
  //   print(response.body);

  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     print(data);
  //     print(response.statusCode);

  //     Get.offAndToNamed(vistorDetailScreen, arguments: userdata);
  //     isLoading = false;
  //     update();

  //     myToast(msg: 'Visitor Added');
  //   } else {
  //     myToast(msg: 'Failed to Add Visitor Detail');
  //     isLoading = false;
  //     update();
  //     throw Exception('Failed to Add Visitor Detail');
  //   }
  // }

  Future addVisitorDetail({
    required int gatekeeperid,
    required int societyid,
    required int subadminid,
    String? houseaddress,
    required String visitortype,
    required String name,
    required String cnic,
    required String mobileno,
    required String vechileno,
    required String arrivaldate,
    required String arrivaltime,
  }) async {
    isLoading.value = true;
    errorAddingVisitor = "";

    var res = await AddVisitorDetailService.updateVisitorDetail(
        gatekeeperid: gatekeeperid,
        societyid: societyid,
        subadminid: subadminid,
        visitortype: visitortype,
        name: name,
        cnic: cnic,
        mobileno: mobileno,
        vechileno: vechileno,
        arrivaldate: arrivaldate,
        arrivaltime: arrivaltime);
    isLoading.value = false;

    if (res is AddVisitorDetailModel) {
      addVisitorDetailModel = res;
      myToast(msg: 'Visitor Added');

      Get.offAndToNamed(vistorDetailScreen, arguments: userdata);
    } else {
      isLoading.value = false;
      errorAddingVisitor = res.toString();
      Get.snackbar("Message", errorAddingVisitor);
    }
  }
}
