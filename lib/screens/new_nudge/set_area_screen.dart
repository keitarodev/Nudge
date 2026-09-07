import 'package:flutter/material.dart';

import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';

class SetAreaScreen extends StatelessWidget {
  final double selectedRadius;
  final ValueChanged<double?> onRadiusChanged;

  const SetAreaScreen({
    super.key,
    required this.selectedRadius,
    required this.onRadiusChanged,
  });

  static const List<double> radiusOptions = [100, 250, 500, 1000];

  String _radiusLabel(double radius) {
    if (radius == 1000) {
      return '1 kilometre';
    }

    return '${radius.toInt()} metres';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reminder radius', style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.small),
        Text(
          'The Nudge will trigger when you cross this area.',
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.normal),
        DropdownButtonFormField<double>(
          initialValue: selectedRadius,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.radar_rounded),
            filled: true,
            fillColor: colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            ),
          ),
          items: radiusOptions.map((radius) {
            return DropdownMenuItem<double>(
              value: radius,
              child: Text(_radiusLabel(radius)),
            );
          }).toList(),
          onChanged: onRadiusChanged,
        ),
      ],
    );
  }
}
