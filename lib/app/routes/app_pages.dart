import 'package:get/get.dart';

import '../modules/add_product/bindings/add_product_binding.dart';
import '../modules/add_product/views/add_product_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/catalog_product/bindings/catalog_product_binding.dart';
import '../modules/catalog_product/views/catalog_product_view.dart';
import '../modules/detail_sale/bindings/detail_sale_binding.dart';
import '../modules/detail_sale/views/detail_sale_view.dart';
import '../modules/example/bindings/example_binding.dart';
import '../modules/example/views/example_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/karyawan/bindings/KaryawanBinding.dart';
import '../modules/karyawan/views/KaryawanView.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart' as profile_view;
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';
import '../modules/report_sales/bindings/report_sales_binding.dart';
import '../modules/report_sales/views/report_sales_view.dart';
import '../modules/sales/bindings/sales_binding.dart';
import '../modules/sales/views/sales_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.EXAMPLE,
      page: () => const ExampleView(),
      binding: ExampleBinding(),
    ),
    GetPage(
      name: _Paths.CATALOG_PRODUCT,
      page: () => const CatalogProductView(),
      binding: CatalogProductBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => const AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => profile_view.ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => const ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.SALES,
      page: () => const SalesView(),
      binding: SalesBinding(),
    ),
    GetPage(
      name: _Paths.KARYAWAN,
      page: () => const KaryawanView(),
      binding: KaryawanBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SALE,
      page: () => const DetailSaleView(),
      binding: DetailSaleBinding(),
    ),
    GetPage(
      name: Routes.REPORT_SALES,
      page: () => const ReportSalesView(),
      binding: ReportSalesBinding(),
    ),
  ];
}
