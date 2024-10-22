import 'package:get/get.dart';
import 'package:test01/app/data/api/auth_api.dart';
import 'package:test01/app/data/local_storage.dart';
import 'package:test01/app/routes/app_pages.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var token = ''.obs;
  final AuthApi _authApi = AuthApi();

  @override
  void onInit() {
    super.onInit();
    LocalStorage.init();
  }

  Future<void> login(String username, String password) async {
    try {
      await LocalStorage.init(); // Ensure LocalStorage is initialized
      final token = await _authApi.login(username, password);
      if (token != null) {
        this.token.value = token;
        isLoggedIn.value = true;
        await LocalStorage.setToken(token);
        Get.toNamed(Routes.CONTACT);
      } else {
        isLoggedIn.value = false;
      }
    } catch (e) {
      isLoggedIn.value = false;
    }
  }

  void logout() {
    token.value = '';
    isLoggedIn.value = false;
    LocalStorage.clearToken();
  }
}