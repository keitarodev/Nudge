import 'package:flutter/material.dart';

import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_colors.dart';
import 'map_test_screen.dart';

class SavedLocationScreen extends StatefulWidget {
  const SavedLocationScreen({super.key});

  @override
  State<SavedLocationScreen> createState() => _SavedLocationScreenState();
}

class _SavedLocationScreenState extends State<SavedLocationScreen> {
  List<String> savedLocations = ["Home", "University"];

  List<String> locationDetails = [
    "123 Street, Phnom Penh",
    "Limkokwing University",
  ];

  void addLocation() {
    showLocationDialog();
  }

  void editLocation(int index) {
    showLocationDialog(index: index);
  }

  void deleteLocation(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Location?"),
          content: Text(
            'Are you sure you want to delete "${savedLocations[index]}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  savedLocations.removeAt(index);
                  locationDetails.removeAt(index);
                });

                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void showLocationDialog({int? index}) {
    final nameController = TextEditingController(
      text: index == null ? "" : savedLocations[index],
    );

    final addressController = TextEditingController(
      text: index == null ? "" : locationDetails[index],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          ),
          title: Text(
            index == null ? "Add Location" : "Edit Location",
            style: AppTextStyles.cardTitle,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Location name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.standard),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: "Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final name = nameController.text.trim();
                final address = addressController.text.trim();

                if (name.isEmpty || address.isEmpty) {
                  return;
                }

                setState(() {
                  if (index == null) {
                    savedLocations.add(name);
                    locationDetails.add(address);
                  } else {
                    savedLocations[index] = name;
                    locationDetails[index] = address;
                  }
                });

                Navigator.pop(context);
              },
              child: Text(
                "Save",
                style: AppTextStyles.buttonText.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.standard,
        title: Text("Saved Location", style: AppTextStyles.heading),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.large,
              AppSpacing.standard,
              AppSpacing.standard,
              0,
            ),
            child: Text("Your Locations", style: AppTextStyles.sectionHeading),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.standard),
              itemCount: savedLocations.length,
              itemBuilder: (context, index) {
                final location = savedLocations[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.small),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.outlineDark.withAlpha((255 * 0.1).round())
                          : AppColors.outlineLight,
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      location == "Home"
                          ? Icons.home_outlined
                          : Icons.location_on_outlined,
                      size: AppSizes.icon,
                    ),
                    title: Text(location),
                    subtitle: Text(locationDetails[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () {
                            editLocation(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            deleteLocation(index);
                          },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MapTestScreen()),
          );
        },
        child: const Icon(Icons.add_location_alt_outlined),
      ),
    );
  }
}
