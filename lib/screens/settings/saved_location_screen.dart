import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../data/app_data.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_colors.dart';
import '../../models/place.dart';
import 'map_picker_screen.dart';

class SavedLocationScreen extends StatefulWidget {
  final bool openAddDialog;

  const SavedLocationScreen({super.key, this.openAddDialog = false});

  @override
  State<SavedLocationScreen> createState() => _SavedLocationScreenState();
}

class _SavedLocationScreenState extends State<SavedLocationScreen> {
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();

    if (widget.openAddDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final placeId = await addLocation();

        if (!mounted) {
          return;
        }

        Navigator.pop(context, placeId);
      });
    }
  }

  Future<MapLocationResult?> chooseLocation(
    LatLng? initialLocation,
    int initialRadius,
  ) async {
    return Navigator.push<MapLocationResult>(
      context,
      MaterialPageRoute(
        builder: (context) => MapPickerScreen(
          initialLocation: initialLocation,
          initialRadius: initialRadius,
        ),
      ),
    );
  }

  Future<String?> addLocation() async {
    return showLocationDialog();
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
            'Are you sure you want to delete '
            '"${AppData.places[index].name}"?',
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
                  AppData.places.removeAt(index);
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

  Future<String?> showLocationDialog({int? index}) async {
    final nameController = TextEditingController(
      text: index == null ? "" : AppData.places[index].name,
    );

    final addressController = TextEditingController(
      text: index == null ? "" : AppData.places[index].address,
    );

    int dialogRadius = index == null
        ? (AppData.radii.isNotEmpty ? AppData.radii.first.meters : 250)
        : AppData.places[index].radius;

    LatLng? dialogLocation = index == null
        ? null
        : LatLng(
            AppData.places[index].latitude,
            AppData.places[index].longitude,
          );

    return showDialog<String>(
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

              const SizedBox(height: AppSpacing.standard),

              OutlinedButton.icon(
                onPressed: () async {
                  final selected = await chooseLocation(
                    dialogLocation,
                    dialogRadius,
                  );

                  if (selected == null) {
                    return;
                  }

                  setState(() {
                    dialogLocation = selected.location;
                    dialogRadius = selected.radius;
                  });
                },
                icon: const Icon(Icons.map_outlined),
                label: Text(
                  dialogLocation == null
                      ? 'Choose on Map'
                      : 'Location Selected',
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
                final name = nameController.text.trim().isEmpty
                    ? 'Your Place'
                    : nameController.text.trim();

                final address = addressController.text.trim().isEmpty
                    ? 'Your Address'
                    : addressController.text.trim();

                final location = dialogLocation;

                if (location == null) {
                  return;
                }

                String? newPlaceId;

                setState(() {
                  if (index == null) {
                    newPlaceId = DateTime.now().millisecondsSinceEpoch
                        .toString();

                    AppData.places.add(
                      SavedPlace(
                        id: newPlaceId!,
                        name: name,
                        address: address,
                        latitude: location.latitude,
                        longitude: location.longitude,
                        radius: dialogRadius,
                      ),
                    );
                  } else {
                    AppData.places[index] = SavedPlace(
                      id: AppData.places[index].id,
                      name: name,
                      address: address,
                      latitude: location.latitude,
                      longitude: location.longitude,
                      radius: dialogRadius,
                    );
                  }
                });

                Navigator.pop(context, newPlaceId);
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
              itemCount: AppData.places.length,
              itemBuilder: (context, index) {
                final place = AppData.places[index];

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
