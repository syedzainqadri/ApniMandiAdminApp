


import 'package:apni_mandi_admin/views/add_data_screen.dart';
import 'package:apni_mandi_admin/views/approved_users.dart';
import 'package:apni_mandi_admin/views/home_screen.dart';
import 'package:apni_mandi_admin/views/login_screen.dart';
import 'package:apni_mandi_admin/views/pending_users_screen.dart';
import 'package:apni_mandi_admin/views/search_user_screen.dart';
import 'package:apni_mandi_admin/views/transactions_screen.dart';
import 'package:apni_mandi_admin/views/users_screen.dart';
import 'package:get/get.dart';
import '../views/mandilist_screen.dart';
import '../views/splash_screen.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/login', page: () => LoginScreen(), transition: Transition.zoom),
    GetPage(name: '/home', page: () => const HomeScreen(), transition: Transition.zoom),
    GetPage(name: '/addData', page: () => const AddDataScreen(), transition: Transition.rightToLeftWithFade),
    GetPage(name: '/users', page: () => const UsersScreen(), transition: Transition.rightToLeftWithFade),
    GetPage(name: '/mandi', page: () => const MandiListScreen(), transition: Transition.rightToLeftWithFade),
    GetPage(name: '/pending', page: () => const PendingUsersScreen(), transition: Transition.rightToLeftWithFade),
    GetPage(name: '/approved', page: () => const ApprovedUsersScreen(), transition: Transition.rightToLeftWithFade),
    GetPage(name: '/transaction', page: () => const TransactionsScreen(), transition: Transition.rightToLeftWithFade),
    GetPage(name: '/searchView', page: () => const SearchUserScreen(), transition: Transition.rightToLeftWithFade),
  ];
}