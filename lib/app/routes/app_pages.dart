import '../../app/modules/auth_module/auth_page.dart';
import '../../app/modules/auth_module/auth_bindings.dart';
import '../../app/modules/contact_module/contact_bindings.dart';
import '../../app/modules/contact_module/contact_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';
abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.CONTACT,
      page: () => ContactPage(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => AuthPage(),
      binding: AuthBinding(),
    ),
  ];
}
