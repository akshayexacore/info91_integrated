import 'package:get/get.dart';
import 'package:info91/src/modules/archived_chat/archived_chats_page.dart';
import 'package:info91/src/modules/auth/login/controllers/auth_controller.dart';
import 'package:info91/src/modules/auth/login/controllers/login_controller.dart';
import 'package:info91/src/modules/auth/login/login_page.dart';
import 'package:info91/src/modules/auth/login/otp_page.dart';
import 'package:info91/src/modules/auth/login/welcome_page.dart';
import 'package:info91/src/modules/chat/chat_page.dart';
import 'package:info91/src/modules/chat/controllers/chat_controller.dart';
import 'package:info91/src/modules/chat_info/chat_info_page.dart';
import 'package:info91/src/modules/chat_info/controllers/chat_info_controller.dart';
import 'package:info91/src/modules/contact_select/contact_select_page.dart';
import 'package:info91/src/modules/contact_select/controllers/contact_select_controller.dart';
import 'package:info91/src/modules/emergency_alaram_update/pages/emergency_updated_main_screen.dart';

import 'package:info91/src/modules/emergency_alaram_update/pages/verify_number_screen.dart';
import 'package:info91/src/modules/emergency_alarm/controllers/emergency_alarm_controller.dart';
import 'package:info91/src/modules/emergency_alarm/emergency_alarm_page.dart';
import 'package:info91/src/modules/forward/controllers/forward_controller.dart';
import 'package:info91/src/modules/forward/forward_page.dart';
import 'package:info91/src/modules/groups/controllers/groups_controller.dart';
import 'package:info91/src/modules/home/controllers/home_controller.dart';
import 'package:info91/src/modules/landing/controllers/landing_controller.dart';
import 'package:info91/src/modules/landing/landing_page.dart';
import 'package:info91/src/modules/network_usage/controllers/network_usage_controller.dart';
import 'package:info91/src/modules/network_usage/network_usage_page.dart';
import 'package:info91/src/modules/profile/controllers/profile_controller.dart';
import 'package:info91/src/modules/profile/controllers/user_profile_controller.dart';
import 'package:info91/src/modules/profile/profile_page.dart';
import 'package:info91/src/modules/profile/user_profile_page.dart';
import 'package:info91/src/modules/recipients/controllers/recipients_add_controller.dart';
import 'package:info91/src/modules/recipients/recipients_add_page.dart';
import 'package:info91/src/modules/settings/controllers/settings_controller.dart';
import 'package:info91/src/modules/settings/settings_page.dart';
import 'package:info91/src/modules/splash/controllers/splash_controller.dart';
import 'package:info91/src/modules/splash/splash_page.dart';
import 'package:info91/src/modules/starred_chats/controllers/starred_chats_controller.dart';
import 'package:info91/src/modules/starred_chats/starred_chats_page.dart';
import 'package:info91/src/modules/status/controllers/status_controller.dart';
import 'package:info91/src/modules/status/story_page.dart';
import 'package:info91/src/modules/storage_and_data/controllers/storage_and_data_controller.dart';
import 'package:info91/src/modules/storage_and_data/storage_and_data.dart';

import '../modules/home/controllers/chats_controller.dart';

class Routes {
  static var getPages = [
    // GetPage(
    //     name: SplashPage.routeName,
    //     page: () => SplashPage(),
    //     binding: BindingsBuilder(() {
    //       Get.lazyPut(() => SplashController());
    //       Get.lazyPut(() => AuthController());
    //     })),
    GetPage(
        name: WelcomePage.routeName,
        page: () => WelcomePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LoginController());
          Get.lazyPut(() => AuthController());
        })),
    GetPage(
        name: LoginPage.routeName,
        page: () => LoginPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LoginController());
          Get.lazyPut(() => AuthController());
        })),
    GetPage(
        name: OtpPage.routeName,
        page: () => OtpPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LoginController());
          Get.lazyPut(() => AuthController());
        })),
    GetPage(
        name: ProfilePage.routeName,
        page: () => ProfilePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProfileController());
          Get.lazyPut(() => AuthController());
        })),
    GetPage(
        name: LandingPage.routeName,
        page: () => LandingPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LandingController());
          Get.lazyPut(() => HomeController());
          Get.lazyPut(() => ChatsController());
          Get.lazyPut(() => GroupsController());
          Get.lazyPut(() => ProfileController());
          Get.lazyPut(() => StatusController());
        })),
    GetPage(
        name: ChatPage.routeName,
        page: () => ChatPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ChatController());
        })),
    GetPage(
        name: UserProfilePage.routeName,
        page: () => UserProfilePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => UserProfileController());
        })),
    GetPage(
        name: ForwardPage.routeName,
        page: () => ForwardPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ForwardController());
        })),
    GetPage(
        name: ChatInfoPage.routeName,
        page: () => ChatInfoPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ChatInfoController());
        })),
    GetPage(
        name: StoryPage.routeName,
        page: () => StoryPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => StatusController());
        })),
    GetPage(
        name: SettingsPage.routeName,
        page: () => SettingsPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SettingsController());
        })),
    GetPage(
        name: ContactSelectPage.routeName,
        page: () => ContactSelectPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ContactSelectController());
        })),
    GetPage(
        name: ArchivedChatsPage.routeName,
        page: () => ArchivedChatsPage(),
        binding: BindingsBuilder(() {})),
    GetPage(
        name: VerifyNumberAlarmScreen.routeName,
        page: () => VerifyNumberAlarmScreen(),
        binding: BindingsBuilder(() {})),
    GetPage(
        name: EmergencyUpdatedMainScreen.routeName,
        page: () => EmergencyUpdatedMainScreen(),
        binding: BindingsBuilder(() {})),
    GetPage(
        name: EmergencyAlarmPage.routeName,
        page: () => EmergencyAlarmPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EmergencyAlarmController());
        })),

    GetPage(
        name: RecipientsAddPage.routeName,
        page: () => RecipientsAddPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => RecipientsAddController());
        })),
    GetPage(
        name: StarredChatsPage.routeName,
        page: () => StarredChatsPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => StarredChatsController());
        })),
    GetPage(
        name: StorageAndData.routeName,
        page: () => StorageAndData(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => StorageAndDataController());
        })),
    GetPage(
        name: NetworkUsagePage.routeName,
        page: () => NetworkUsagePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => NetworkUsageController());
        })),
  ];
}
