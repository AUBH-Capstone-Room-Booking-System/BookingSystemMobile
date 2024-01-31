import 'package:get/get.dart';

import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
import '../modules/booking/bindings/booking_binding.dart';
import '../modules/booking/views/booking_view.dart';
import '../modules/calendar/bindings/calendar_binding.dart';
import '../modules/calendar/views/calendar_view.dart';
import '../modules/editbooking/bindings/editbooking_binding.dart';
import '../modules/editbooking/views/editbooking_view.dart';
import '../modules/favorites/bindings/favorites_binding.dart';
import '../modules/favorites/views/favorites_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/managebookings/bindings/managebookings_binding.dart';
import '../modules/managebookings/views/managebookings_view.dart';
import '../modules/manageusers/bindings/manageusers_binding.dart';
import '../modules/manageusers/views/manageusers_view.dart';
import '../modules/reset/bindings/reset_binding.dart';
import '../modules/reset/views/reset_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING,
      page: () => const BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.EDITBOOKING,
      page: () => const EditbookingView(),
      binding: EditbookingBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITES,
      page: () => const FavoritesView(),
      binding: FavoritesBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => const AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.CALENDAR,
      page: () => const CalendarView(),
      binding: CalendarBinding(),
    ),
    GetPage(
      name: _Paths.RESET,
      page: () => const ResetView(),
      binding: ResetBinding(),
    ),
    GetPage(
      name: _Paths.MANAGEUSERS,
      page: () => const ManageusersView(),
      binding: ManageusersBinding(),
    ),
    GetPage(
      name: _Paths.MANAGEBOOKINGS,
      page: () => const ManagebookingsView(),
      binding: ManagebookingsBinding(),
    ),
  ];
}
