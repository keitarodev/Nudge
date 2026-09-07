import 'package:flutter/material.dart';

import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import 'set_area_screen.dart';

class ChoosePlaceScreen extends StatelessWidget {
  final String placeName;
  final double selectedRadius;
  final ValueChanged<String> onPlaceChanged;
  final ValueChanged<double> onRadiusChanged;

  const ChoosePlaceScreen({
    super.key,
    required this.placeName,
    required this.selectedRadius,
    required this.onPlaceChanged,
    required this.onRadiusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Where should we remind you?', style: textTheme.displayLarge),
          const SizedBox(height: AppSpacing.small),
          Text(
            'Enter a place and choose the reminder area.',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.extraLarge),

          Text('Place', style: textTheme.titleLarge),
          const SizedBox(height: AppSpacing.small),
          TextFormField(
            initialValue: placeName,
            maxLength: 60,
            onChanged: onPlaceChanged,
            decoration: InputDecoration(
              hintText: 'Example: University',
              prefixIcon: const Icon(Icons.location_on_outlined),
              filled: true,
              fillColor: colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.large),

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
