import 'package:flutter/material.dart';

import '../../data/app_data.dart';
import '../../models/nudge.dart';
import '../../models/nudge_category.dart';
import '../../models/place.dart';

import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class EditNudgeBottomSheet extends StatefulWidget {
  final Nudge nudge;
  final List<NudgeCategory> categories;
  final List<SavedPlace> places;

  const EditNudgeBottomSheet({
    super.key,
    required this.nudge,
    required this.categories,
    required this.places,
  });

  @override
  State<EditNudgeBottomSheet> createState() =>
      _EditNudgeBottomSheetState();
}

class _EditNudgeBottomSheetState
    extends State<EditNudgeBottomSheet> {
  late TextEditingController titleController;

  late String selectedCategoryId;
  late String selectedPlaceId;
  late NudgeTrigger selectedTrigger;

  @override
  void initState() {
    super.initState();

    // Current title
    titleController = TextEditingController(
      text: widget.nudge.title,
    );

    // Select the whole title
    titleController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: titleController.text.length,
    );

    // Current information
    selectedCategoryId = widget.nudge.categoryId;
    selectedPlaceId = widget.nudge.placeId;
    selectedTrigger = widget.nudge.trigger;
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  String getCategoryName() {
    final category = widget.categories.firstWhere(
      (item) => item.id == selectedCategoryId,
    );

    return category.name;
  }

  String getPlaceName() {
    final place = widget.places.firstWhere(
      (item) => item.id == selectedPlaceId,
    );

    return place.name;
  }

  Future<void> selectPlace() async {
    final selectedPlace = await showModalBottomSheet<SavedPlace>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(
              AppSpacing.large,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Place',
                  style: AppTextStyles.heading,
                ),

                const SizedBox(
                  height: AppSpacing.standard,
                ),

                for (final place in widget.places)
                  ListTile(
                    leading: const Icon(
                      Icons.location_on_outlined,
                    ),
                    title: Text(
                      place.name,
                    ),
                    subtitle: Text(
                      place.address,
                    ),
                    trailing: selectedPlaceId == place.id
                        ? const Icon(
                            Icons.check,
                          )
                        : null,
                    onTap: () {
                      Navigator.pop(
                        context,
                        place,
                      );
                    },
                  ),

                const SizedBox(
                  height: AppSpacing.small,
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selectedPlace != null) {
      setState(() {
        selectedPlaceId = selectedPlace.id;
      });
    }
  }

  Future<void> selectTrigger() async {
    final selected = await showModalBottomSheet<NudgeTrigger>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(
              AppSpacing.large,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Trigger',
                  style: AppTextStyles.heading,
                ),

                const SizedBox(
                  height: AppSpacing.standard,
                ),

                for (final trigger in NudgeTrigger.values)
                  ListTile(
                    leading: const Icon(
                      Icons.notifications_outlined,
                    ),
                    title: Text(
                      trigger.label,
                    ),
                    trailing: selectedTrigger == trigger
                        ? const Icon(
                            Icons.check,
                          )
                        : null,
                    onTap: () {
                      Navigator.pop(
                        context,
                        trigger,
                      );
                    },
                  ),

                const SizedBox(
                  height: AppSpacing.small,
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        selectedTrigger = selected;
      });
    }
  }

  void saveChanges() {
    final updatedNudge = Nudge(
      id: widget.nudge.id,
      title: titleController.text.trim(),
      categoryId: selectedCategoryId,
      placeId: selectedPlaceId,
      trigger: selectedTrigger,
      radius: widget.nudge.radius,
      status: widget.nudge.status,
      createdAt: widget.nudge.createdAt,
    );

    Navigator.pop(
      context,
      updatedNudge,
    );
  }

  // Delete Nudge
  Future<void> deleteNudge() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete Nudge?',
          ),
          content: const Text(
            'Are you sure you want to delete this nudge?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text(
                'Cancel',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      AppData.nudges.removeWhere(
        (item) => item.id == widget.nudge.id,
      );

      if (mounted) {
        Navigator.pop(
          context,
          true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            AppSpacing.large,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(
                height: AppSpacing.large,
              ),

              // Title
              Text(
                'Edit Nudge',
                style: AppTextStyles.heading,
              ),

              const SizedBox(
                height: AppSpacing.small,
              ),

              // Description
              Text(
                'Update your reminder information',
                style: theme.textTheme.bodyMedium,
              ),

              const SizedBox(
                height: AppSpacing.large,
              ),

              // Nudge title
              TextField(
                controller: titleController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Nudge title',
                  prefixIcon: const Icon(
                    Icons.edit_outlined,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSizes.radiusMedium,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: AppSpacing.standard,
              ),

              // Category
              DropdownButtonFormField<String>(
                initialValue: selectedCategoryId,
                decoration: InputDecoration(
                  labelText: 'Category',
                  prefixIcon: const Icon(
                    Icons.category_outlined,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSizes.radiusMedium,
                    ),
                  ),
                ),
                items: [
                  for (final category in widget.categories)
                    DropdownMenuItem(
                      value: category.id,
                      child: Text(
                        category.name,
                      ),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedCategoryId = value;
                    });
                  }
                },
              ),

              const SizedBox(
                height: AppSpacing.standard,
              ),

              // Place
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.location_on_outlined,
                  color: theme.colorScheme.primary,
                ),
                title: const Text(
                  'Place',
                ),
                subtitle: Text(
                  getPlaceName(),
                  style: theme.textTheme.bodyMedium,
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: selectPlace,
              ),

              const SizedBox(
                height: AppSpacing.small,
              ),

              // Trigger
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.notifications_outlined,
                  color: theme.colorScheme.primary,
                ),
                title: const Text(
                  'Trigger',
                ),
                subtitle: Text(
                  selectedTrigger.label,
                  style: theme.textTheme.bodyMedium,
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: selectTrigger,
              ),

              const SizedBox(
                height: AppSpacing.large,
              ),

              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: saveChanges,
                  child: const Text(
                    'Save Changes',
                  ),
                ),
              ),

              const SizedBox(
                height: AppSpacing.small,
              ),

              // Delete button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: deleteNudge,
                  child: Text(
                    'Delete Nudge',
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}