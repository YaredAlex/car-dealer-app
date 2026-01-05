import 'package:car_dealer/core/services/api_controller.dart';
import 'package:car_dealer/core/services/api_endpoints.dart';
import 'package:car_dealer/model/card_model.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarDetailController extends GetxController {
  final Rx<CarModel?> car = Rx<CarModel?>(null);
  final RxList<CarModel> similarCars = <CarModel>[].obs;
  final RxBool isLoading = RxBool(false);
  final RxInt currentImageIndex = 0.obs;
  final CarouselSliderController carouselController =
      CarouselSliderController();

  @override
  void onInit() {
    super.onInit();
    int carId = 1;
    fetchCarDetails(carId);
    // fetchSimilarCars(carId); // Optionally fetch similar
  }

  Future<void> fetchCarDetails(int id) async {
    try {
      isLoading.value = true;
      // Simulate or use actual API
      // var response = await ApiService().get(APIEndPoint.carDetail(id));
      // car.value = CarModel.fromJson(response); Assume CarModel has fromJson
      final CarModel arg = Get.arguments as CarModel;
      car.value = arg;
    } catch (e) {
      // showErrorPopup("$e");
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSimilarCars(int id) async {
    try {
      // Simulate or use actual API
      var response = await ApiService().get(APIEndPoint.similarCars(id));
      similarCars.value = (response as List<dynamic>)
          .map((e) => CarModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changeImage(int index) {
    currentImageIndex.value = index;
    carouselController.animateToPage(index);
  }

  void toggleLike() {
    // Implement like logic, e.g., car.value?.isLiked = !car.value?.isLiked;
    // Then update API if needed
    car.refresh();
  }

  void reportIssue() {
    // Open dialog or navigate to report form
    Get.defaultDialog(
      title: "Report Issue",
      content: const Text("Describe the issue:"),
      // Add TextField and submit button
    );
  }
}
