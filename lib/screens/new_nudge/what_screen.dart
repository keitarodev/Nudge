import 'package:flutter/material.dart';

import '../../models/nudge_category.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';

class WhatScreen extends StatelessWidget {
  final String title;
  final String? selectedCategory;
  final List<NudgeCategory> categories;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String?> onCategoryChanged;

  const WhatScreen({
    super.key,
    required this.title,
    required this.selectedCategory,
    required this.categories,
    required this.onTitleChanged,
    required this.onCategoryChanged,
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
            'What should we remind you?',
            style: textTheme.displayLarge,
          ),
          const SizedBox(
            height: AppSpacing.small,
          ),
          Text(
            'Enter your reminder and choose a category.',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(
            height: AppSpacing.extraLarge,
          ),

          Text(
            'Reminder',
            style: textTheme.titleLarge,
          ),
          const SizedBox(
            height: AppSpacing.small,
          ),
          TextFormField(
            initialValue: title,
            maxLength: 60,
            onChanged: onTitleChanged,
            decoration: InputDecoration(
              hintText: 'Example: Buy medicine',
              prefixIcon: const Icon(
                Icons.notifications_none_rounded,
              ),
              filled: true,
              fillColor: colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppSizes.radiusSmall,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: AppSpacing.large,
          ),

          Text(
            'Category',
            style: textTheme.titleLarge,
          ),
          const SizedBox(
            height: AppSpacing.small,
          ),

          DropdownButtonFormField<String>(
            initialValue: selectedCategory,
            decoration: InputDecoration(
              hintText: 'Select a category',
              prefixIcon: const Icon(
                Icons.category_outlined,
              ),
              filled: true,
              fillColor: colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppSizes.radiusSmall,
                ),
              ),
            ),
            items: categories.map((category) {
              return DropdownMenuItem<String>(
                value: category.id,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: onCategoryChanged,
          ),
        ],
      ),
    );
  }
}