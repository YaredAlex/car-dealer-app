import 'package:car_dealer/core/colors/colors.dart';
import 'package:car_dealer/core/services/device.dart';
import 'package:car_dealer/modules/explore/controller/card_detail_ctrl.dart';
import 'package:car_dealer/modules/explore/view/full_screen_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CarDetailView extends GetView<CarDetailController> {
  final controller = Get.put(CarDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.bgGray,
      appBar: AppBar(
        backgroundColor: CColors.bgGray,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: Colors.black),
          onPressed: Get.back,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.bookmark_outline, color: Colors.black),
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final car = controller.car.value;
        if (car == null) {
          return const Center(child: Text("Car not found"));
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _showFullImages(
                    context, car.images, controller.currentImageIndex.value),
                child: CarouselSlider(
                  carouselController: controller.carouselController,
                  options: CarouselOptions(
                    height: 220,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) =>
                        controller.currentImageIndex.value = index,
                  ),
                  items: car.images.map((imageUrl) {
                    return Image(
                      image: resolveImage(imageUrl),
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      child: Text(
                        car.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Sections for specs
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Basic Info",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          GridView.count(
                            crossAxisCount: 2,
                            padding: const EdgeInsets.all(8),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            children: [
                              _specItem(Iconsax.car, "Model", car.model),
                              _specItem(Iconsax.shop, "Maker", car.brand),
                              _specItem(
                                  Iconsax.color_swatch, "Color", car.color),
                              _specItem(Iconsax.calendar_1, "Year",
                                  car.year.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Pricing",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GridView.count(
                            crossAxisCount: 2,
                            padding: const EdgeInsets.all(8),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            children: [
                              _specItem(Iconsax.bank, "Bank Price",
                                  "ETB ${car.priceBank}"),
                              _specItem(Iconsax.money, "Cash Price",
                                  "ETB ${car.priceCash}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Performance",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GridView.count(
                            crossAxisCount: 2,
                            padding: const EdgeInsets.all(8),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            children: [
                              _specItem(Iconsax.setting_2, "Transmission",
                                  car.transmission),
                              _specItem(Iconsax.speedometer, "Mileage",
                                  "${car.mileage} km"),
                              _specItem(
                                  Iconsax.gas_station, "Fuel", car.fuelType),
                              _specItem(
                                  Iconsax.flash,
                                  "Engine",
                                  car.engine ??
                                      "N/A"), // Assuming engine field like "2000 cc" or "150 hp"
                              if (car.fuelType.toLowerCase() == 'electric')
                                _specItem(Iconsax.battery_charging, "Battery",
                                    car.batteryCondition ?? "N/A"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Features section

                    Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Features",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: car.features!.map((feature) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: CColors.bgGray,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(feature),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Make Offer button
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: OutlinedButton(
                        onPressed: () {
                          // Implement make offer logic
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          side: const BorderSide(color: Colors.blue),
                        ),
                        child: const Text("Make Offer"),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Row buttons
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                // Implement post ad logic
                              },
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 48),
                                side: const BorderSide(color: Colors.green),
                              ),
                              child: const Text("Post Ad"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: controller.reportIssue,
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 48),
                                side: const BorderSide(color: Colors.red),
                              ),
                              child: const Text("Report Ad"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Similar ads
                    const Text(
                      "Similar Ads",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.similarCars.length,
                        itemBuilder: (context, index) {
                          final similar = controller.similarCars[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16)),
                                    child: Image.network(
                                      similar.images.first,
                                      height: 120,
                                      width: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      similar.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      "ETB ${similar.priceCash}",
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _specItem(IconData icon, String title, String? value) {
    return Row(
      children: [
        Icon(icon, size: 22, color: Colors.black87),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text("$value",
                  style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }

  void _showFullImages(
      BuildContext context, List<String> images, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => FullScreenImageViewer(
          images: images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
}
