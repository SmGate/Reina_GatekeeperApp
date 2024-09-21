import 'package:gatekeeper/Module/Login/View/login_screen.dart';
import 'package:gatekeeper/Module/Pre%20Approve%20Entry%20Residents/View/pre_approve_entry_residents.dart';
import 'package:gatekeeper/Module/ResidentParkingScan/view/vahicle_number_scanner.dart';
import 'package:gatekeeper/Routes/screen_binding.dart';
import 'package:get/get.dart';

import '../Module/AddVistorDetail/View/add_visitor_detail_screen.dart';
import '../Module/Events/View/events_screen.dart';
import '../Module/HomeScreen/View/home_screen.dart';
import '../Module/NoticeBoard/View/notice_board_screen.dart';
import '../Module/Pre Approved Guests/View/pre_approved_guests.dart';
import '../Module/ResidentQrEntryExit/view/all_resident_reocords.dart';
import '../Module/Residental Emergency/View/residential_emergency_screen.dart';
import '../Module/Splash/View/splash_screen.dart';
import '../Module/Vistor Detail/View/vistor_detail_screen.dart';
import 'set_routes.dart';

class RouteManagement {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: splashscreen,
          page: () => SplashScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: loginscreen,
          page: () => Login(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: homescreen,
          page: () => HomeScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: preApproveEntryResidents,
          page: () => PreApproveEntryResidents(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: preApprovedGuests,
          page: () => PreApprovedGuests(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: eventsscreen,
          page: () => EventsScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: noticeboardscreen,
          page: () => NoticeBoardScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: vistorDetailScreen,
          page: () => VisitorDetailScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: addVistorDetailScreen,
          page: () => AddVisitorDetailScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: residentialEmergencyScreen,
          page: () => ResidentialEmergencyScreen(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: vehicleNumberScannerScreen,
          page: () => VehicleNumberScanner(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
      GetPage(
          name: residentRecords,
          page: () => AllResidentRecord(),
          binding: ScreenBindings(),
          transition: Transition.noTransition),
    ];
  }
}
