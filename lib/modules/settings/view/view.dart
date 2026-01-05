import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _settingItem(Iconsax.user, "Profile"),
          _settingItem(Iconsax.language_square, "Language"),
          _settingItem(Iconsax.moon, "Dark Mode"),
          _settingItem(Iconsax.shield_tick, "Privacy & Security"),
          _settingItem(Iconsax.info_circle, "About Dealer"),
        ],
      ),
    );
  }

  Widget _settingItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Iconsax.arrow_right_3),
      onTap: () {},
    );
  }
}
