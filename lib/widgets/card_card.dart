import 'package:car_dealer/core/routes/app_routes.dart';
import 'package:car_dealer/model/card_model.dart';
import 'package:car_dealer/modules/explore/controller/explore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CarCard extends StatelessWidget {
  final CarModel car;

  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExploreController>();

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.carDetail, arguments: car),
      child: Card(
        margin: const EdgeInsets.all(12),
        child: Column(
          children: [
            Image.network(car.images.first, fit: BoxFit.cover),
            ListTile(
              title: Text(car.name),
              subtitle: Text("${car.brand} • ${car.year}"),
              trailing: IconButton(
                icon: Icon(
                  car.isLiked ? Iconsax.heart5 : Iconsax.heart,
                  color: Colors.redAccent,
                ),
                onPressed: () => controller.toggleLike(car),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
