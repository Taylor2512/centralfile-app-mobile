import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:test01/app/routes/app_pages.dart';
import 'package:test01/app/theme/app_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test01/app/data/local_storage.dart'; // Persistencia local

void main({String env = 'development'}) async {
  await Hive.initFlutter();
  await LocalStorage.init();

  await dotenv.load(fileName: env == 'production' ? ".env.production" : ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: appThemeData,
        initialRoute: Routes.AUTH,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
