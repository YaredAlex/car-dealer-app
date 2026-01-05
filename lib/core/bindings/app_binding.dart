import 'package:car_dealer/modules/explore/controller/explore_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(HomeController());
    Get.put(ExploreController());
    // Get.put(CarDetailController());
  }
}
