import 'package:car_dealer/model/card_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_dealer/core/services/api_controller.dart';

enum SortOption {
  priceLowToHigh,
  priceHighToLow,
  yearNewToOld,
  yearOldToNew,
  mileageLowToHigh,
}

class ExploreController extends GetxController {
  // =========================
  // API SERVICE
  // =========================
  final ApiService api = ApiService();

  // =========================
  // STATE
  // =========================
  final isLoading = false.obs;
  final error = ''.obs;
  final sortOption = Rx<SortOption?>(null);

  // =========================
  // DATA SOURCES
  // =========================
  final allCars = <CarModel>[].obs; // full list from API
  final cars = <CarModel>[].obs; // filtered list for UI

  // =========================
  // SEARCH & FILTER STATE
  // =========================
  final searchText = ''.obs;
  final selectedBrand = Rx<String?>(null);
  final selectedFuel = Rx<String?>(null);
  final selectedYear = Rx<int?>(null);
  // YEAR RANGE
  final yearRange = Rx<RangeValues>(const RangeValues(1980, 2024));
  // KM DRIVEN
  final maxKm = RxDouble(200000);

// PRICE RANGE
  final cashPriceRange = Rx<RangeValues>(const RangeValues(0, 3000000));
  final loanPriceRange = Rx<RangeValues>(const RangeValues(0, 3000000));
  // =========================
  // DEALER BRANCHES
  // =========================
  final branches = <String>[
    "Addis Ababa - Bole",
    "Addis Ababa - CMC",
    "Adama Branch",
  ];

  final selectedBranch = "Addis Ababa - Bole".obs;

  // =========================
  // LIFECYCLE
  // =========================
  @override
  void onInit() {
    fetchCars();
    super.onInit();
  }

  // =========================
  // API FETCH (PLACEHOLDER)
  // =========================
  Future<void> fetchCars() async {
    try {
      isLoading.value = true;
      error.value = '';

      /// 🔹 PLACEHOLDER FOR REAL API
      /// Example later:
      /// final response = await api.get('/cars', query: {...});
      /// allCars.assignAll(CarModel.fromList(response.data));

      await Future.delayed(const Duration(seconds: 1));
      allCars.assignAll(_dummyCars);

      applyFilters();
    } catch (e) {
      error.value = "Failed to load cars";
    } finally {
      isLoading.value = false;
    }
  }

  void toggleBrand(String brand) {
    if (selectedBrand.value == brand) {
      selectedBrand.value = null; // deselect
    } else {
      selectedBrand.value = brand;
    }
    applyFilters();
  }

  // =========================
  // SEARCH
  // =========================
  void onSearch(String value) {
    searchText.value = value;
    applyFilters();
    debugPrint("onSearch is $value");
  }

  // =========================
  // FILTER LOGIC
  // =========================
  void applyFilters() {
    List<CarModel> filtered = allCars.where((car) {
      final matchSearch = searchText.value.isEmpty ||
          car.name.toLowerCase().contains(searchText.value.toLowerCase());

      final matchBrand =
          selectedBrand.value == null || car.brand == selectedBrand.value;

      final matchFuel =
          selectedFuel.value == null || car.fuelType == selectedFuel.value;

      final matchYear =
          car.year >= yearRange.value.start && car.year <= yearRange.value.end;

      final matchCashPrice = car.priceCash >= cashPriceRange.value.start &&
          car.priceCash <= cashPriceRange.value.end;

      final matchLoanPrice = car.priceBank >= loanPriceRange.value.start &&
          car.priceBank <= loanPriceRange.value.end;

      final matchKm = car.mileage <= maxKm.value;

      return matchSearch &&
          matchBrand &&
          matchFuel &&
          matchYear &&
          matchCashPrice &&
          matchLoanPrice &&
          matchKm;
    }).toList();

    // 🔀 SORTING
    switch (sortOption.value) {
      case SortOption.priceLowToHigh:
        filtered.sort((a, b) => a.priceCash.compareTo(b.priceCash));
        break;
      case SortOption.priceHighToLow:
        filtered.sort((a, b) => b.priceCash.compareTo(a.priceCash));
        break;
      case SortOption.yearNewToOld:
        filtered.sort((a, b) => b.year.compareTo(a.year));
        break;
      case SortOption.yearOldToNew:
        filtered.sort((a, b) => a.year.compareTo(b.year));
        break;
      case SortOption.mileageLowToHigh:
        filtered.sort((a, b) => a.mileage.compareTo(b.mileage));
        break;
      default:
        break;
    }

    cars.assignAll(filtered);
  }

  void clearFilters() {
    selectedBrand.value = null;
    selectedFuel.value = null;
    searchText.value = '';
    yearRange.value = const RangeValues(1980, 2024);
    cashPriceRange.value = const RangeValues(0, 3000000);
    loanPriceRange.value = const RangeValues(0, 3000000);
    maxKm.value = 200000;
    applyFilters();
  }

  // =========================
  // LIKE / SAVE
  // =========================
  void toggleLike(CarModel car) {
    car.isLiked = !car.isLiked;
    cars.refresh();
  }

  // =========================
  // DUMMY DATA (TEMP)
  // =========================
  final List<CarModel> _dummyCars = [
    CarModel(
        id: 1,
        name: "Toyota bz4x",
        brand: "Toyota",
        year: 2021,
        priceCash: 2300000,
        priceBank: 1500000,
        fuelType: "Electric",
        mileage: 42000,
        transmission: "Automatic",
        images: [
          "assets/cars/toyota_bz4x.jpg",
          "assets/cars/toyota_bz4x_interior.jpg",
        ],
        postDate: DateTime.now(),
        features: [
          "Airbags",
          "CD Player",
          "Electric Mirros",
          "Leather Seats",
          "Spotlight"
        ]),
    CarModel(
      id: 2,
      name: "BYD seagull",
      brand: "BYD",
      year: 2023,
      priceCash: 1500000,
      priceBank: 120000,
      fuelType: "Electric",
      mileage: 12000,
      transmission: "Automatic",
      images: [
        "assets/cars/byd_seagull.jpg",
        "assets/cars/byd_seagull_inside.jpg",
      ],
      postDate: DateTime.now(),
    ),
  ];
}
