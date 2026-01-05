import 'dart:io';
import 'package:car_dealer/core/services/api_controller.dart';
import 'package:car_dealer/model/card_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import '../../explore/controller/explore_controller.dart';
import 'package:dio/dio.dart';

class PostAdController extends GetxController {
  // =========================
  // FORM CONTROLLERS
  // =========================
  final nameCtrl = TextEditingController();
  final plateCtrl = TextEditingController();
  final cashPriceCtrl = TextEditingController();
  final bankPriceCtrl = TextEditingController();
  final mileageCtrl = TextEditingController();

  // =========================
  // SELECT VALUES
  // =========================
  final brand = Rx<String?>(null);
  final model = Rx<String?>(null);
  final color = Rx<String?>(null);
  final fuel = Rx<String?>(null);
  final transmission = Rx<String?>(null);
  final engine = Rx<String?>(null);
  final battery = Rx<String?>("N/A");
  final year = Rx<int?>(null);

  // =========================
  // FEATURES
  // =========================
  final selectedFeatures = <String>[].obs;

  // =========================
  // IMAGES
  // =========================
  final images = <File>[].obs;
  final ImagePicker _picker = ImagePicker();
  RxBool isLoading = false.obs;
  // =========================
  // IMAGE PICK + COMPRESS
  // =========================

  Future<void> pickImage() async {
    try {
      final XFile? picked =
          await _picker.pickImage(source: ImageSource.gallery);

      if (picked == null) return;

      final File originalFile = File(picked.path);
      final File? compressed = await _compressImage(originalFile);

      if (compressed != null) {
        images.add(compressed);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image");
    }
  }

  Future<File?> _compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath =
        '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    final XFile? compressedXFile =
        await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70,
      minWidth: 1080,
      minHeight: 720,
      format: CompressFormat.jpeg,
    );

    if (compressedXFile == null) return null;

    return File(compressedXFile.path); // ✅ CONVERT
  }

  // =========================
  // FEATURE TOGGLE
  // =========================
  void toggleFeature(String feature) {
    if (selectedFeatures.contains(feature)) {
      selectedFeatures.remove(feature);
    } else {
      selectedFeatures.add(feature);
    }
  }

  // =========================
  // SUBMIT AD
  // =========================
  void submitAd() async {
    // 🔴 BASIC VALIDATION
    if (images.isEmpty) {
      Get.snackbar("Missing Images", "Please add at least one car image");
      return;
    }

    if (nameCtrl.text.isEmpty ||
        brand.value == null ||
        year.value == null ||
        fuel.value == null ||
        transmission.value == null ||
        cashPriceCtrl.text.isEmpty ||
        mileageCtrl.text.isEmpty) {
      Get.snackbar("Missing Fields", "Please fill all required fields");
      return;
    }
    try {
      isLoading.value = true;
      final cashPrice = double.tryParse(cashPriceCtrl.text);
      final bankPrice = double.tryParse(bankPriceCtrl.text);
      final mileage = int.tryParse(mileageCtrl.text);

      if (cashPrice == null || mileage == null) {
        Get.snackbar("Invalid Input", "Please enter valid numeric values");
        return;
      }

      final newCar = CarModel(
        id: DateTime.now().millisecondsSinceEpoch,
        name: nameCtrl.text.trim(),
        brand: brand.value!,
        year: year.value!,
        plateNo: plateCtrl.text.trim(),
        priceCash: cashPrice,
        priceBank: bankPrice ?? 0,
        fuelType: fuel.value!,
        mileage: mileage,
        transmission: transmission.value!,
        images: images.map((e) => e.path).toList(),
        postDate: DateTime.now(),
        model: model.value,
        color: color.value,
        engine: engine.value,
        batteryCondition: battery.value,
        features: selectedFeatures,
      );

      // ➕ ADD TO EXPLORE LIST (DEMO)
      final explore = Get.find<ExploreController>();
      explore.allCars.insert(0, newCar);
      explore.applyFilters();

      final formData = FormData();

      // ---- Fields ----
      newCar.toJson().forEach((key, value) {
        if (value != null && key != "images") {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      });

      // ---- Images ----
      for (final image in images) {
        formData.files.add(
          MapEntry(
            "images",
            await MultipartFile.fromFile(
              image.path,
              filename: image.path.split('/').last,
            ),
          ),
        );
      }

      // ---- Send Request ----
      await ApiService().post(
        "/api/car/",
        data: formData,
      );
      // 🧹 CLEAR FORM
      clearForm();
      Get.back();
      Get.snackbar("Success", "Car ad posted successfully");
    } catch (e) {
      Get.snackbar(
        "Error",
        "$e",
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    nameCtrl.clear();
    plateCtrl.clear();
    cashPriceCtrl.clear();
    bankPriceCtrl.clear();
    mileageCtrl.clear();

    brand.value = null;
    year.value = null;
    fuel.value = null;
    transmission.value = null;
    model.value = null;
    color.value = null;
    engine.value = null;
    battery.value = null;

    selectedFeatures.clear();
    images.clear();
  }

  void removeImage(int index) {
    images.removeAt(index);
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    cashPriceCtrl.dispose();
    bankPriceCtrl.dispose();
    mileageCtrl.dispose();
    super.onClose();
  }
}
