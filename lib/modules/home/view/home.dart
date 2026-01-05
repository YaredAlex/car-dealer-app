import 'package:car_dealer/modules/explore/view/explore.dart';
import 'package:car_dealer/modules/post_ad/view/post_ad.dart';
import 'package:car_dealer/modules/saved/view/saved.dart';
import 'package:car_dealer/modules/settings/view/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeView extends StatelessWidget {
  final RxInt index = 0.obs;

  final pages = [
    ExploreView(),
    SavedView(),
    PostAdView(),
    // NotificationView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: pages[index.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index.value,
            onTap: (i) => index.value = i,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Iconsax.search_normal),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.heart),
                label: 'Saved',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.add),
                label: 'Post Ad',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Iconsax.notification),
              //   label: 'Notifications',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.setting),
                label: 'Settings',
              ),
            ],
          ),
        ));
  }
}
