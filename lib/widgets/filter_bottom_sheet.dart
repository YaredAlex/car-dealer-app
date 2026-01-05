import 'package:car_dealer/modules/explore/controller/explore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterBottomSheet extends StatelessWidget {
  final controller = Get.find<ExploreController>();

  final fuels = ["Petrol", "Electric", "Hybrid", "CNG", "Others"];
  final brands = ["Toyota", "BMW", "Audi", "Tesla"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Brand"),
            _chipRow(brands, controller.selectedBrand),
            _title("Fuel Type"),
            _chipRow(fuels, controller.selectedFuel),
            _title("Manufacturing Year"),
            _yearRangeSlider(),
            _title("Cash Price Range"),
            _priceRangeSlider(controller.cashPriceRange, "ETB "),
            _title("Loan Price Range"),
            _priceRangeSlider(controller.loanPriceRange, "ETB "),
            _title("Max KM Driven"),
            _kmSlider(),
            _title("Sort By"),
            Wrap(
              spacing: 8,
              children: [
                _sortChip("Price ↑", SortOption.priceLowToHigh),
                _sortChip("Price ↓", SortOption.priceHighToLow),
                _sortChip("Newest", SortOption.yearNewToOld),
                _sortChip("Oldest", SortOption.yearOldToNew),
                _sortChip("Low KM", SortOption.mileageLowToHigh),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      controller.clearFilters();
                      Get.back();
                    },
                    child: const Text("Reset"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.applyFilters();
                      Get.back();
                    },
                    child: const Text("Apply"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------
  // WIDGETS
  // -------------------------
  Widget _sortChip(String label, SortOption option) {
    return Obx(() => ChoiceChip(
          label: Text(label),
          selected: controller.sortOption.value == option,
          onSelected: (_) => controller.sortOption.value = option,
        ));
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _chipRow<T>(List<T> items, Rx<T?> selected) {
    return Wrap(
      spacing: 8,
      children: items.map((item) {
        return Obx(() => ChoiceChip(
              label: Text(item.toString()),
              selected: selected.value == item,
              onSelected: (_) => selected.value = item,
            ));
      }).toList(),
    );
  }

  // YEAR RANGE
  Widget _yearRangeSlider() {
    return Obx(() => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${controller.yearRange.value.start.round()}"),
                Text("${controller.yearRange.value.end.round()}"),
              ],
            ),
            RangeSlider(
              min: 1980,
              max: 2024,
              divisions: 44,
              values: controller.yearRange.value,
              onChanged: (v) => controller.yearRange.value = v,
            ),
          ],
        ));
  }

  // PRICE RANGE
  Widget _priceRangeSlider(Rx<RangeValues> range, String label) {
    return Obx(() => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$label${range.value.start.round()}"),
                Text("$label${range.value.end.round()}"),
              ],
            ),
            RangeSlider(
              min: 0,
              max: 3000000,
              divisions: 20,
              values: range.value,
              onChanged: (v) => range.value = v,
            ),
          ],
        ));
  }

  // KM SLIDER (FIXED)
  Widget _kmSlider() {
    return Obx(() => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("0 km"),
                Text(
                  controller.maxKm.value >= 200000
                      ? "200k+"
                      : "${controller.maxKm.value.round()} km",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Slider(
              min: 0,
              max: 200000,
              divisions: 20,
              value: controller.maxKm.value,
              onChanged: (v) => controller.maxKm.value = v,
            ),
          ],
        ));
  }
}
