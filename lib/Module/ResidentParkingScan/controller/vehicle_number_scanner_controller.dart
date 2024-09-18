import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gatekeeper/Module/Login/Model/User.dart';
import 'package:gatekeeper/Module/ResidentParkingScan/model/send_notification_to_resident_model.dart';
import 'package:gatekeeper/utils/Constants/api_routes.dart';
import 'package:gatekeeper/utils/Constants/constants.dart';
import 'package:gatekeeper/utils/styles/colors.dart';
import 'package:gatekeeper/utils/styles/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/vehicle_owner_info_model.dart' as v;
import '../service/vehicle_owner_info_service.dart';

class VehicleNumberScannerController extends GetxController {
  var user = Get.arguments;
  late final User userdata;
  final ImagePicker _picker = ImagePicker();
  final Rx<XFile?> _image = Rx<XFile?>(null);
  final RxString _vehicleNumber = ''.obs;
  TextEditingController vNoController = TextEditingController();
  XFile? get image => _image.value;
  String get vehicleNumber => _vehicleNumber.value;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var vehicleOwnerInfo = v.VehicleOwnerModel();
  String errorGetttingInfo = "";
  Uri? uri;
  RxBool loading = false.obs;
//////////////////////////
  RxBool loadingSendingNotification = false.obs;
  String errorSendingNotification = "";
  var notificationModel = SendNotificationToResidentModel();
  ////////////////////
  @override
  void onInit() {
    super.onInit();
    userdata = user;
  }

  // Method to capture image, crop it, and extract text
  Future<void> captureAndExtractText() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        _image.value = image; // Update the state with the captured image

        // Crop the captured image
        final File? croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
          ),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        );

        if (croppedFile != null) {
          _image.value = XFile(croppedFile.path);

          await _extractTextFromImage(croppedFile.path);
        } else {
          print("Cropping was cancelled or failed.");
        }
      }
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  Future<void> _extractTextFromImage(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();

    try {
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      String fullText = recognizedText.text;

      // Extract vehicle number using regular expression
      String? vehicleNumber = extractVehicleNumber(fullText);

      _vehicleNumber.value = vehicleNumber ?? 'No vehicle number found';
    } catch (e) {
      print("Error processing image: $e");
    } finally {
      textRecognizer.close(); // Release resources used by the TextRecognizer
    }
  }

  // Method to extract vehicle number using a regular expression
  String? extractVehicleNumber(String text) {
    String formattedText = text.replaceAll(RegExp(r'\s+'), ' ');

    final RegExp regExp = RegExp(
      r'\b[A-Z0-9]{2,}\s*[-\s]?\s*[A-Z0-9]{1,4}\b',
      caseSensitive: false,
    );

    final match = regExp.firstMatch(formattedText);
    if (match != null) {
      String vehicleNumber = match.group(0)!;

      vehicleNumber = vehicleNumber.replaceAll(RegExp(r'[\s-]'), '');
      return vehicleNumber;
    }
    return null;
  }

  void getVehicleOwnerData({
    String? vehicleNo,
    BuildContext? context,
  }) async {
    loading.value = true;
    errorGetttingInfo = "";
    var res =
        await VehicleOwnerService.getVehicleOwnerData(vehicleNo: vehicleNo);
    loading.value = false;
    if (res is v.VehicleOwnerModel) {
      vehicleOwnerInfo = res;
      if (context != null && vehicleOwnerInfo.success == true) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return userInfoDialogue(context: context, model: vehicleOwnerInfo);
          },
        );
      } else {
        Get.snackbar("Message", "No Record Found");
      }
    } else {
      loading.value = false;
      errorGetttingInfo = res.toString();
      Get.snackbar("Error", errorGetttingInfo);
    }
  }

  void sendNotificationToResident(
      {String? residentId, BuildContext? context}) async {
    loadingSendingNotification.value = true;
    errorSendingNotification = "";
    var res = await VehicleOwnerService.sendNotificationToResident(
        residentId: residentId);
    loadingSendingNotification.value = false;
    if (res is SendNotificationToResidentModel) {
      notificationModel = res;
      Navigator.of(context!).pop();
      Get.snackbar("Message", notificationModel.message.toString());
    } else {
      loadingSendingNotification.value = false;
      errorSendingNotification = res.toString();
      Get.snackbar("Error", errorSendingNotification);
    }
  }
}

Widget userInfoDialogue(
    {required BuildContext context, required v.VehicleOwnerModel model}) {
  var c = Get.find<VehicleNumberScannerController>();
  return AlertDialog(
    content: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: CachedNetworkImage(
                  imageUrl:
                      "${Api.imageBaseUrl}${model.data!.user?.image ?? ""}",
                  placeholder: (context, url) => CircularProgressIndicator(
                    color: AppColors.appThem,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 240,
            child: Center(
              child: Text(
                "${model.data?.user?.firstname} ${model.data?.user?.lastname}",
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 16.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Center(
              child: Text(
                model.data?.houseaddress ?? "",
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.dark,
                    fontWeight: FontWeight.normal),
                maxLines: 2,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  text1Styling(text: "Country"),
                  SizedBox(
                    height: 10,
                  ),
                  text1Styling(text: "Vehicle No"),
                  SizedBox(
                    height: 10,
                  ),
                  text1Styling(text: "Mobile"),
                  SizedBox(
                    height: 10,
                  ),
                  text1Styling(text: "Resident Type"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  text2Styling(text: model.data?.country),
                  SizedBox(
                    height: 10,
                  ),
                  text2Styling(text: model.data?.vechileno),
                  SizedBox(
                    height: 10,
                  ),
                  text2Styling(text: model.data?.user?.mobileno),
                  SizedBox(
                    height: 10,
                  ),
                  text2Styling(text: model.data?.residenttype),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround, // Distribute buttons evenly
                children: [
                  // Notify Button
                  Expanded(
                    child: Obx(() => ElevatedButton(
                          onPressed: () {
                            c.sendNotificationToResident(
                                residentId: c.vehicleOwnerInfo.data?.residentid
                                    .toString(),
                                context: context);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue, // Text color
                            textStyle:
                                TextStyle(fontSize: 12), // Smaller text size
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // Button border radius
                            ),
                          ),
                          child: c.loadingSendingNotification.value
                              ? SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: AppColors.globalWhite,
                                  ),
                                )
                              : Text('NOTIFY'),
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  // Call Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final phoneNumber = model.data?.user?.mobileno ?? "";

                        c.uri = Uri.parse("tel://${phoneNumber}");

                        try {
                          await launchUrl(c.uri!);
                          c.uri = null;
                        } catch (e) {
                          myToast(msg: e.toString(), isNegative: true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        textStyle: TextStyle(fontSize: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('CALL'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red, // Text color
                    textStyle: TextStyle(fontSize: 12), // Smaller text size
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Button border radius
                    ),
                  ),
                  child: Text('CANCEL'),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget text1Styling({String? text}) {
  return Text(
    text ?? "",
    style: reusableTextStyle(
        textStyle: GoogleFonts.dmSans(),
        fontSize: 14.0,
        color: AppColors.textBlack,
        fontWeight: FontWeight.bold),
  );
}

Widget text2Styling({String? text}) {
  return SizedBox(
    child: Text(
      text ?? "",
      style: reusableTextStyle(
          textStyle: GoogleFonts.dmSans(),
          fontSize: 14.0,
          color: AppColors.dark,
          fontWeight: FontWeight.normal),
      maxLines: 2,
    ),
  );
}
