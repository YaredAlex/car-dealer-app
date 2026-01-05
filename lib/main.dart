import 'package:car_dealer/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/bindings/app_binding.dart';
import 'core/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DealerApp());
}

class DealerApp extends StatelessWidget {
  const DealerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Solution Car Market',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.pages,
    );
  }
}
