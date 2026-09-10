import 'package:flutter/material.dart';

import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_colors.dart';
import '../../models/place.dart';

class SavedLocationScreen extends StatefulWidget {
  const SavedLocationScreen({super.key});

  @override
  State<SavedLocationScreen> createState() => _SavedLocationScreenState();
}

class _SavedLocationScreenState extends State<SavedLocationScreen> {
  List<SavedPlace> savedPlaces = [
    SavedPlace(id: "home_01", name: "Home", address: "123 Street, Phnom Penh"),
    SavedPlace(
      id: "university_01",
      name: "University",
      address: "Limkokwing University",
    ),
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
          title: const Text("Delete Place?"),
          content: Text(
            'Are you sure you want to delete "${savedPlaces[index].name}"?',
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
                  savedPlaces.removeAt(index);
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
      text: index == null ? "" : savedPlaces[index].name,
    );

    final addressController = TextEditingController(
      text: index == null ? "" : savedPlaces[index].address,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          ),
          title: Text(
            index == null ? "Add Place" : "Edit Place",
            style: AppTextStyles.cardTitle,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Place name",
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
                    savedPlaces.add(
                      SavedPlace(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: name,
                        address: address,
                      ),
                    );
                  } else {
                    savedPlaces[index] = SavedPlace(
                      id: savedPlaces[index].id,
                      name: name,
                      address: address,
                    );
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
        title: Text("Saved Places", style: AppTextStyles.heading),
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
            child: Text("Your Places", style: AppTextStyles.sectionHeading),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.standard),
              itemCount: savedPlaces.length,
              itemBuilder: (context, index) {
                final place = savedPlaces[index];

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
                      place.name == "Home"
                          ? Icons.home_outlined
                          : Icons.location_on_outlined,
                      size: AppSizes.icon,
                    ),
                    title: Text(place.name),
                    subtitle: Text(place.address),
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
        onPressed: addLocation,
        child: const Icon(Icons.add_location_alt_outlined),
      ),
    );
  }
}
