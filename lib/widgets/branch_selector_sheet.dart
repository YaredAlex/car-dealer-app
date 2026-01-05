import 'package:car_dealer/modules/explore/controller/explore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BranchSelectorSheet extends StatelessWidget {
  final controller = Get.find<ExploreController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select Branch",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...controller.branches.map((branch) {
            return Obx(() => ListTile(
                  title: Text(branch),
                  trailing: controller.selectedBranch.value == branch
                      ? const Icon(Iconsax.tick_circle, color: Colors.green)
                      : null,
                  onTap: () {
                    controller.selectedBranch.value = branch;
                    Get.back();
                  },
                ));
          }).toList(),
        ],
      ),
    );
  }
}
