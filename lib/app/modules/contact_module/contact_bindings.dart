import 'package:test01/app/modules/contact_module/contact_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ContactBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactController());
  }
}
