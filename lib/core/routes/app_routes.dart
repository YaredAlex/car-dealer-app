import 'package:car_dealer/modules/explore/view/card_detail.dart';
import 'package:car_dealer/modules/home/view/home.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const home = '/';
  static const carDetail = '/car-detail';

  static final pages = [
    GetPage(name: home, page: () => HomeView()),
    GetPage(name: carDetail, page: () => CarDetailView()),
  ];
}
