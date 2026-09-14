import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../data/app_data.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../models/nudge_radius.dart';

class MapLocationResult {
  final LatLng location;
  final int radius;

  const MapLocationResult({required this.location, required this.radius});
}

class MapPickerScreen extends StatefulWidget {
  final LatLng? initialLocation;
  final int? initialRadius;

  const MapPickerScreen({super.key, this.initialLocation, this.initialRadius});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  late LatLng _selectedLocation;
  late double _radius;

  @override
  void initState() {
    super.initState();

    _selectedLocation =
        widget.initialLocation ?? const LatLng(11.5564, 104.9282);

    _radius =
        widget.initialRadius?.toDouble() ??
        (AppData.radii.isNotEmpty
            ? AppData.radii.first.meters.toDouble()
            : 250);
  }

  Future<int?> addRadius() async {
    final controller = TextEditingController();

    return showDialog<int>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          ),
          title: Text('Add Radius', style: AppTextStyles.cardTitle),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Radius in meters',
              suffixText: 'm',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final meters = int.tryParse(controller.text.trim());

                if (meters == null || meters <= 0) {
                  return;
                }

                AppData.radii.add(
                  NudgeRadius(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    meters: meters,
                  ),
                );

                Navigator.pop(dialogContext, meters);
              },
              child: Text(
                'Save',
                style: AppTextStyles.buttonText.copyWith(
                  color: Theme.of(dialogContext).colorScheme.primary,
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.standard,
        title: Text('Choose Location', style: AppTextStyles.heading),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: _selectedLocation,
                initialZoom: 15,
                onTap: (tapPosition, point) {
                  setState(() {
                    _selectedLocation = point;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.nudge',
                ),
                CircleLayer(
                  circles: [
                    CircleMarker(
                      point: _selectedLocation,
                      radius: _radius,
                      useRadiusInMeter: true,
                      color: theme.colorScheme.primary.withValues(alpha: 0.15),
                      borderColor: theme.colorScheme.primary,
                      borderStrokeWidth: 2,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _selectedLocation,
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.location_pin,
                        size: 40,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(AppSpacing.large),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                top: BorderSide(color: theme.colorScheme.outlineVariant),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Selected Location', style: AppTextStyles.cardTitle),

                const SizedBox(height: AppSpacing.small),

                Text(
                  '${_selectedLocation.latitude.toStringAsFixed(6)}, '
                  '${_selectedLocation.longitude.toStringAsFixed(6)}',
                  style: theme.textTheme.bodyMedium,
                ),

                const SizedBox(height: AppSpacing.standard),

                Text('Radius', style: AppTextStyles.cardTitle),

                const SizedBox(height: AppSpacing.small),

                InkWell(
                  onTap: () async {
                    final selected = await showModalBottomSheet<double>(
                      context: context,
                      showDragHandle: true,
                      builder: (bottomSheetContext) {
                        return SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.large,
                              0,
                              AppSpacing.large,
                              AppSpacing.large,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Choose Radius',
                                  style: AppTextStyles.heading,
                                ),

                                const SizedBox(height: AppSpacing.standard),

                                for (final radius in AppData.radii)
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: const Icon(Icons.radar_outlined),
                                    title: Text('${radius.meters} m'),
                                    trailing: _radius == radius.meters
                                        ? Icon(
                                            Icons.check_rounded,
                                            color: Theme.of(
                                              bottomSheetContext,
                                            ).colorScheme.primary,
                                          )
                                        : null,
                                    onTap: () {
                                      Navigator.pop(
                                        bottomSheetContext,
                                        radius.meters.toDouble(),
                                      );
                                    },
                                  ),

                                const SizedBox(height: AppSpacing.small),

                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(Icons.add_circle_outline),
                                  title: const Text('Add Radius'),
                                  onTap: () async {
                                    Navigator.pop(bottomSheetContext);

                                    final addedRadius = await addRadius();

                                    if (addedRadius == null) {
                                      return;
                                    }

                                    setState(() {
                                      _radius = addedRadius.toDouble();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );

                    if (selected == null) {
                      return;
                    }

                    setState(() {
                      _radius = selected;
                    });
                  },
                  borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.normal,
                      vertical: AppSpacing.normal,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.outline),
                      borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.radar_outlined,
                          color: theme.colorScheme.primary,
                        ),

                        const SizedBox(width: AppSpacing.normal),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Radius', style: theme.textTheme.bodySmall),
                              Text(
                                '${_radius.toInt()} m',
                                style: AppTextStyles.cardTitle,
                              ),
                            ],
                          ),
                        ),

                        const Icon(Icons.keyboard_arrow_down_rounded),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.standard),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MapLocationResult(
                          location: _selectedLocation,
                          radius: _radius.toInt(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Confirm Location'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
