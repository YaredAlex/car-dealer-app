import 'package:car_dealer/modules/post_ad/controller/post_ad_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PostAdView extends StatelessWidget {
  final controller = Get.put(PostAdController());

  final features = [
    "Airbag",
    "ABS",
    "Electric Mirrors",
    "Leather Seats",
    "CD Player",
    "Parking Sensors",
    "Rear Camera",
    "Cruise Control",
    "Air Conditioning",
    "Power Steering",
    "Alloy Wheels",
    "Bluetooth Connectivity",
    "Navigation System",
    "Sunroof",
    "Heated Seats",
    "Keyless Entry",
    "Fog Lights",
    "Anti-theft System",
    "USB Ports",
    "Apple CarPlay",
    "Android Auto",
    "Blind Spot Monitoring",
    "Lane Departure Warning",
    "Adaptive Cruise Control",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post Car Ad")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _section("Images", _imageSection()),
            _section("Basic Info", _basicInfo()),
            _section("Pricing", _pricing()),
            _section("Performance", _performance()),
            _section("Features", _features()),
            const SizedBox(height: 16),
            _submitButton(),
          ],
        ),
      ),
    );
  }

  // ---------------- SECTION WRAPPER ----------------
  Widget _section(String title, Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  // ---------------- IMAGE SECTION ----------------
  Widget _imageSection() {
    return Obx(() => GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.images.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (_, i) {
            // ➕ ADD IMAGE TILE
            if (i == controller.images.length) {
              return GestureDetector(
                onTap: controller.pickImage,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Iconsax.add, size: 26),
                  ),
                ),
              );
            }

            // 🖼 IMAGE TILE
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    controller.images[i],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),

                // ❌ REMOVE BUTTON
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: () => controller.removeImage(i),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Iconsax.close_circle,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }

  // ---------------- BASIC INFO ----------------
  Widget _basicInfo() {
    return Column(
      children: [
        _input(controller.nameCtrl, "Car Name"),
        _dropdown(
            controller.brand,
            [
              "Toyota",
              "BYD",
              "Jetour",
              "Swift",
              "Kia",
              "Hyundai",
              "Radar",
              "Avatr",
              "Honda",
              "BMW",
              "Mazda",
              "Mahindra",
              "Audi",
              "Nissan",
            ],
            "Brand"),
        _dropdown(
            controller.color,
            ["Black", "White", "Silver", "Gray", "Blue", "Red", "Green"],
            "Color"),
        _yearPicker(),
        _input(controller.plateCtrl, "Plate No"),
      ],
    );
  }

  // ---------------- PRICING ----------------
  Widget _pricing() {
    return Column(
      children: [
        _input(controller.cashPriceCtrl, "Cash Price", isNumber: true),
        _input(controller.bankPriceCtrl, "Bank Loan Price", isNumber: true),
      ],
    );
  }

  // ---------------- PERFORMANCE ----------------
  Widget _performance() {
    return Column(
      children: [
        _dropdown(
            controller.transmission, ["Automatic", "Manual"], "Transmission"),
        _dropdown(controller.fuel, ["Petrol", "Electric", "Hybrid"], "Fuel"),
        _input(controller.mileageCtrl, "Mileage (km)", isNumber: true),
        _dropdown(controller.engine, ["1.6L", "2.0L", "Electric"], "Engine"),
        _dropdown(controller.battery, ["N/A", "Good", "Excellent"], "Battery"),
      ],
    );
  }

  // ---------------- FEATURES ----------------
  Widget _features() {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: 8,
        children: features.map((f) {
          return Obx(() => FilterChip(
                label: Text(f),
                selected: controller.selectedFeatures.contains(f),
                onSelected: (_) => controller.toggleFeature(f),
              ));
        }).toList(),
      ),
    );
  }

  // ---------------- SUBMIT ----------------
  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () => ElevatedButton(
          onPressed: controller.isLoading.value ? null : controller.submitAd,
          child: controller.isLoading.value
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: const CircularProgressIndicator(),
                )
              : const Text("Upload Ad"),
        ),
      ),
    );
  }

  // ---------------- HELPERS ----------------
  Widget _input(TextEditingController c, String label,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        controller: c,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget _dropdown(Rx<String?> value, List<String> items, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Obx(() => DropdownButtonFormField<String>(
            value: value.value,
            hint: Text(label),
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => value.value = v,
          )),
    );
  }

  Widget _yearPicker() {
    return Obx(() => ListTile(
          title: Text(controller.year.value == null
              ? "Select Year"
              : controller.year.value.toString()),
          trailing: const Icon(Iconsax.calendar),
          onTap: () async {
            final picked = await showDatePicker(
              context: Get.context!,
              firstDate: DateTime(1980),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
            );
            if (picked != null) controller.year.value = picked.year;
          },
        ));
  }
}
