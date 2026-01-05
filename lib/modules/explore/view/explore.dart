import 'dart:io';

import 'package:car_dealer/core/colors/colors.dart';
import 'package:car_dealer/core/services/device.dart';
import 'package:car_dealer/model/card_model.dart';
import 'package:car_dealer/modules/explore/controller/explore_controller.dart';
import 'package:car_dealer/widgets/branch_selector_sheet.dart';
import 'package:car_dealer/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ExploreView extends StatelessWidget {
  final controller = Get.find<ExploreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.bgGray,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _searchBar(),
            _brandSection(),
            _carList(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Dealer Logo + Name
          Row(
            children: [
              Container(
                height: 42,
                width: 42,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/logos/solution.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Solution car market",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Trusted Car Marketplace",
                    style: TextStyle(
                      fontSize: 12,
                      color: CColors.softGray,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Dealer Address
          GestureDetector(
            onTap: () => Get.bottomSheet(
              BranchSelectorSheet(),
              isScrollControlled: true,
            ),
            child: Row(
              children: [
                const Icon(Iconsax.location, size: 18, color: CColors.softGray),
                const SizedBox(width: 4),
                Obx(() => Text(
                      controller.selectedBranch.value,
                      style: const TextStyle(
                          fontSize: 13, color: CColors.softGray),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Find your car",
                  prefixIcon: Icon(Iconsax.search_normal),
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) => controller.onSearch(value),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => Get.bottomSheet(
              FilterBottomSheet(),
              isScrollControlled: true,
            ),
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: CColors.primaryBlack,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Iconsax.setting_4, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _brandSection() {
    final controller = Get.find<ExploreController>();

    final brands = [
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
    ];

    final brandLogos = [
      "assets/logos/toyota.jpg",
      "assets/logos/byd.jpg",
      "assets/logos/jetour.png",
      "assets/logos/swift.png",
      "assets/logos/kia.png",
      "assets/logos/hyundai.png",
      "assets/logos/renault.jpg",
      "assets/logos/avatr.png",
      "assets/logos/honda.png",
      "assets/logos/bmw.png",
      "assets/logos/mazda.png",
      "assets/logos/mahindra.png",
      "assets/logos/audi.png",
      "assets/logos/nissan.png",
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: 90,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: brands.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, i) {
            return Obx(() {
              final isSelected = controller.selectedBrand.value == brands[i];

              return GestureDetector(
                onTap: () => controller.toggleBrand(brands[i]),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? CColors.primaryBlack
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                )
                              ]
                            : [],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            brandLogos[i],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      brands[i],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected
                            ? CColors.primaryBlack
                            : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget _carList() {
    return Expanded(
      child: Obx(() => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.cars.length,
            itemBuilder: (_, i) => _carCard(controller.cars[i]),
          )),
    );
  }

  Widget _carCard(CarModel car) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Get.toNamed('/car-detail', arguments: car),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // IMAGE + HEART
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image(
                      image: resolveImage(car.images.first),
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // HEART BUTTON
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () => controller.toggleLike(car),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          car.isLiked ? Iconsax.heart5 : Iconsax.heart,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      car.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              // META + PRICE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${car.year} • ${car.brand}",
                    style: const TextStyle(color: CColors.softGray),
                  ),
                  Text(
                    "ETB ${car.priceCash}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
