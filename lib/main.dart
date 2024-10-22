import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test01/app/routes/app_pages.dart';
import 'package:test01/app/theme/app_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test01/app/data/local_storage.dart'; // Persistencia local

void main() async {
  // Inicializa Hive y GetStorage para la persistencia local
  await Hive.initFlutter();
  await LocalStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: appThemeData,
        initialRoute: Routes.AUTH, // Ruta inicial
      getPages: AppPages.pages, // Definir las rutas usando GetX
      debugShowCheckedModeBanner: false,
    );
  }
}
