class CarModel {
  final int id;
  final String name;
  final String brand;
  final int year;
  final double priceCash;
  final double priceBank;
  final String fuelType;
  final int mileage;
  final String transmission;
  final List<String> images;
  final DateTime postDate;
  bool isLiked;
  final String? model;
  final String? color;
  final String? batteryCondition;
  final String? engine;
  List<String>? features = <String>[];
  final String? plateNo;

  CarModel(
      {required this.id,
      required this.name,
      required this.brand,
      required this.year,
      required this.priceCash,
      required this.priceBank,
      required this.fuelType,
      required this.mileage,
      required this.transmission,
      required this.images,
      required this.postDate,
      this.isLiked = false,
      this.model,
      this.color,
      this.batteryCondition,
      this.features = const [],
      this.engine,
      this.plateNo});

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] as int,
      name: json['name'] as String,
      brand: json['brand'] as String,
      year: json['year'] as int,
      priceCash: (json['price_cash'] as num).toDouble(),
      priceBank: (json['price_bank'] as num).toDouble(),
      fuelType: json['fuel_type'] as String,
      mileage: json['mileage'] as int,
      transmission: json['transmission'] as String,
      images: List<String>.from(json['images'] as List),
      postDate: DateTime.parse(json['post_date'] as String),
      isLiked: json['is_liked'] as bool? ?? false,
      model: json['model'] as String?,
      color: json['color'] as String?,
      batteryCondition: json['battery_condition'] as String?,
      features: json['features'] != null
          ? List<String>.from(json['features'] as List)
          : [],
      plateNo: json['plate_no'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "brand": brand,
      "year": year,
      "price_cash": priceCash,
      "price_bank": priceBank,
      "fuel_type": fuelType,
      "mileage": mileage,
      "transmission": transmission,
      "images": images, // List<String>
      "post_date": postDate.toIso8601String(),
      "is_liked": isLiked,
      "model": model,
      "color": color,
      "battery_condition": batteryCondition,
      "engine": engine,
      "features": features?.join(", ") ?? "N/A",
      "plate_no": plateNo,
    };
  }
}
