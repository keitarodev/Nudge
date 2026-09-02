import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Preferences",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),

          const SizedBox(height: 8.0),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.brightness_6_outlined),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 12.0),
                  title: const Text("Appearance"),
                  subtitle: const Text("Light and dark mode"),
                  onTap: () {
                    print("Appearance Tapped");
                  },
                ),

                const Divider(height: 1.0),

                ListTile(
                  leading: const Icon(Icons.notifications_outlined),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 12.0),
                  title: const Text("Notifications"),
                  subtitle: const Text("Manage notifications"),
                  onTap: () {
                    print("Notifications Tapped");
                  },
                ),

                const Divider(height: 1.0),

                ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 12.0),
                  title: const Text("Location"),
                  subtitle: const Text("Manage location settings"),
                  onTap: () {
                    print("Location Tapped");
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20.0),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Personalization",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),

          const SizedBox(height: 8.0),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              leading: const Icon(Icons.category_outlined),
              trailing: const Icon(Icons.arrow_forward_ios, size: 12.0),
              title: const Text("Categories"),
              subtitle: const Text("Manage your categories"),
              onTap: () {
                print("Categories Tapped");
              },
            ),
          ),

          const SizedBox(height: 20.0),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "About",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),

          const SizedBox(height: 8.0),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              trailing: const Icon(Icons.arrow_forward_ios, size: 12.0),
              title: const Text("About Nudge"),
              subtitle: const Text("Version and app information"),
              onTap: () {
                print("About Tapped");
              },
            ),
          ),
        ],
      ),
    );
  }
}
