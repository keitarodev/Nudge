import 'package:flutter/material.dart';

import '../../data/app_data.dart';
import '../../models/nudge_radius.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class RadiusScreen extends StatefulWidget {
  const RadiusScreen({super.key});

  @override
  State<RadiusScreen> createState() => _RadiusScreenState();
}

class _RadiusScreenState extends State<RadiusScreen> {
  void addRadius() {
    showRadiusDialog();
  }

  void editRadius(int index) {
    showRadiusDialog(index: index);
  }

  void deleteRadius(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Radius?'),
          content: Text(
            'Are you sure you want to delete '
            '"${AppData.radii[index].meters} m"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  AppData.radii.removeAt(index);
                });

                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void showRadiusDialog({int? index}) {
    final controller = TextEditingController(
      text: index == null ? '' : AppData.radii[index].meters.toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          ),
          title: Text(
            index == null ? 'Add Radius' : 'Edit Radius',
            style: AppTextStyles.cardTitle,
          ),
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
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final meters = int.tryParse(controller.text.trim());

                if (meters == null || meters <= 0) {
                  return;
                }

                setState(() {
                  if (index == null) {
                    AppData.radii.add(
                      NudgeRadius(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        meters: meters,
                      ),
                    );
                  } else {
                    AppData.radii[index] = NudgeRadius(
                      id: AppData.radii[index].id,
                      meters: meters,
                    );
                  }
                });

                Navigator.pop(context);
              },
              child: Text(
                'Save',
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
        title: Text('Radius', style: AppTextStyles.heading),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Radius Settings',
                  style: AppTextStyles.sectionHeading,
                ),
                const SizedBox(height: AppSpacing.small),
                Text(
                  'Manage the distance options used '
                  'for your Nudges.',
                  style: AppTextStyles.body.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.standard),
              itemCount: AppData.radii.length,
              itemBuilder: (context, index) {
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
                    leading: const Icon(Icons.radio_button_checked_outlined),
                    title: Text('${AppData.radii[index].meters} m'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () {
                            editRadius(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            deleteRadius(index);
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
        onPressed: addRadius,
        child: const Icon(Icons.add),
      ),
    );
  }
}
