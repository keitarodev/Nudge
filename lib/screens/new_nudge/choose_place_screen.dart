import 'package:flutter/material.dart';

import '../../models/place.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import 'set_area_screen.dart';

class ChoosePlaceScreen extends StatelessWidget {
  final String placeName;
  final double selectedRadius;
  final List<SavedPlace> places;
  final ValueChanged<String> onPlaceChanged;
  final ValueChanged<double> onRadiusChanged;

  const ChoosePlaceScreen({
    super.key,
    required this.placeName,
    required this.selectedRadius,
    required this.places,
    required this.onPlaceChanged,
    required this.onRadiusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(
        AppSpacing.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Where should we remind you?',
            style: textTheme.displayLarge,
          ),
          const SizedBox(
            height: AppSpacing.small,
          ),
          Text(
            'Choose a saved place and set the reminder area.',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(
            height: AppSpacing.extraLarge,
          ),

          Text(
            'Place',
            style: textTheme.titleLarge,
          ),
          const SizedBox(
            height: AppSpacing.small,
          ),

          DropdownButtonFormField<String>(
            initialValue: placeName.isEmpty
                ? null
                : placeName,
            decoration: InputDecoration(
              hintText: 'Select a saved place',
              prefixIcon: const Icon(
                Icons.location_on_outlined,
              ),
              filled: true,
              fillColor: colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppSizes.radiusSmall,
                ),
              ),
            ),
            items: places.map((place) {
              return DropdownMenuItem<String>(
                value: place.id,
                child: Text(place.name),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                onPlaceChanged(value);
              }
            },
          ),

          const SizedBox(
            height: AppSpacing.large,
          ),

          SetAreaScreen(
            selectedRadius: selectedRadius,
            onRadiusChanged: (radius) {
              if (radius != null) {
                onRadiusChanged(radius);
              }
            },
          ),
        ],
      ),
    );
  }
}