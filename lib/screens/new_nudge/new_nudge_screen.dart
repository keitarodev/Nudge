import 'package:flutter/material.dart';

import '../../data/app_data.dart';
import '../../models/nudge.dart';
import '../../models/place.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import 'nudge_saved_screen.dart';

class NewNudgeScreen extends StatefulWidget {
  const NewNudgeScreen({super.key});

  @override
  State<NewNudgeScreen> createState() {
    return _NewNudgeScreenState();
  }
}

class _NewNudgeScreenState extends State<NewNudgeScreen> {
  String title = '';
  String? selectedCategory;
  String? selectedPlace;
  NudgeTrigger selectedTrigger = NudgeTrigger.arrive;
  double selectedRadius = 250;

  Nudge? savedNudge;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  bool _validateNudge() {
    if (title.trim().isEmpty) {
      _showMessage('Please enter a reminder.');
      return false;
    }

    if (selectedCategory == null) {
      _showMessage('Please select a category.');
      return false;
    }

    if (selectedPlace == null) {
      _showMessage('Please select a place.');
      return false;
    }

    return true;
  }

  Nudge _createNudge() {
    return Nudge(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      categoryId: selectedCategory!,
      placeId: selectedPlace!,
      trigger: selectedTrigger,
      radius: selectedRadius.toInt(),
      status: 'active',
      createdAt: DateTime.now(),
      lastTriggeredAt: null,
    );
  }

  void _saveNudge() {
    if (!_validateNudge()) {
      return;
    }

    final nudge = _createNudge();

    AppData.nudges.add(nudge);

    setState(() {
      savedNudge = nudge;
    });
  }

  void _resetForm() {
    setState(() {
      title = '';
      selectedCategory = null;
      selectedPlace = null;
      selectedTrigger = NudgeTrigger.arrive;
      selectedRadius = 250;
      savedNudge = null;
    });
  }

  Future<void> _selectPlace() async {
    final selected = await showModalBottomSheet<SavedPlace>(
      context: context,
      builder: (context) {
        final colors = Theme.of(context).colorScheme;
        final textTheme = Theme.of(context).textTheme;

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
                  style: textTheme.headlineSmall,
                ),

                const SizedBox(
                  height: AppSpacing.standard,
                ),

                for (final place in AppData.places)
                  ListTile(
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: colors.primary,
                    ),
                    title: Text(
                      place.name,
                    ),
                    subtitle: Text(
                      place.address,
                    ),
                    trailing: selectedPlace == place.id
                        ? Icon(
                            Icons.check_rounded,
                            color: colors.primary,
                          )
                        : null,
                    onTap: () {
                      Navigator.pop(
                        context,
                        place,
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        selectedPlace = selected.id;
      });
    }
  }

  Future<void> _selectTrigger() async {
    final selected = await showModalBottomSheet<NudgeTrigger>(
      context: context,
      builder: (context) {
        final colors = Theme.of(context).colorScheme;
        final textTheme = Theme.of(context).textTheme;

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
                  style: textTheme.headlineSmall,
                ),

                const SizedBox(
                  height: AppSpacing.standard,
                ),

                for (final trigger in NudgeTrigger.values)
                  ListTile(
                    leading: Icon(
                      Icons.notifications_none_rounded,
                      color: colors.primary,
                    ),
                    title: Text(
                      trigger.label,
                    ),
                    trailing: selectedTrigger == trigger
                        ? Icon(
                            Icons.check_rounded,
                            color: colors.primary,
                          )
                        : null,
                    onTap: () {
                      Navigator.pop(
                        context,
                        trigger,
                      );
                    },
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Subtle neutral grey used by the Settings-style outlines.
    final borderColor = colors.onSurface.withValues(
      alpha: 0.12,
    );

    if (savedNudge != null) {
      return Scaffold(
        body: SafeArea(
          child: NudgeSavedScreen(
            nudge: savedNudge!,
            onCreateAnother: _resetForm,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(
                  AppSpacing.large,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What do you want to remember?',
                      style: textTheme.displayLarge,
                    ),

                    const SizedBox(
                      height: AppSpacing.small,
                    ),

                    Text(
                      'Create a reminder for a place you visit.',
                      style: textTheme.bodyLarge?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.extraLarge,
                    ),

                    // Reminder
                    Text(
                      'Reminder',
                      style: textTheme.titleLarge,
                    ),

                    const SizedBox(
                      height: AppSpacing.small,
                    ),

                    TextField(
                      maxLength: 60,
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Example: Buy medicine',
                        prefixIcon: const Icon(
                          Icons.notifications_none_rounded,
                        ),
                        filled: true,
                        fillColor: colors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusSmall,
                          ),
                          borderSide: BorderSide(
                            color: borderColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusSmall,
                          ),
                          borderSide: BorderSide(
                            color: borderColor,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.normal,
                    ),

                    // Category
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
                        fillColor: colors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusSmall,
                          ),
                          borderSide: BorderSide(
                            color: borderColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusSmall,
                          ),
                          borderSide: BorderSide(
                            color: borderColor,
                          ),
                        ),
                      ),
                      items: AppData.categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.id,
                          child: Text(
                            category.name,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    ),

                    const SizedBox(
                      height: AppSpacing.normal,
                    ),

                    // Place
                    Text(
                      'Place',
                      style: textTheme.titleLarge,
                    ),

                    const SizedBox(
                      height: AppSpacing.small,
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusSmall,
                        ),
                        border: Border.all(
                          color: borderColor,
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.location_on_outlined,
                          color: colors.primary,
                        ),
                        title: Text(
                          selectedPlace == null
                              ? 'Select a saved place'
                              : AppData.places
                                  .firstWhere(
                                    (place) =>
                                        place.id == selectedPlace,
                                  )
                                  .name,
                        ),
                        trailing: const Icon(
                          Icons.chevron_right_rounded,
                        ),
                        onTap: _selectPlace,
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.normal,
                    ),

                    // Trigger
                    Text(
                      'Trigger',
                      style: textTheme.titleLarge,
                    ),

                    const SizedBox(
                      height: AppSpacing.small,
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusSmall,
                        ),
                        border: Border.all(
                          color: borderColor,
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.notifications_none_rounded,
                          color: colors.primary,
                        ),
                        title: Text(
                          selectedTrigger.label,
                        ),
                        trailing: const Icon(
                          Icons.chevron_right_rounded,
                        ),
                        onTap: _selectTrigger,
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.normal,
                    ),

                    // Reminder radius
                    Text(
                      'Reminder radius',
                      style: textTheme.titleLarge,
                    ),

                    const SizedBox(
                      height: AppSpacing.small,
                    ),

                    DropdownButtonFormField<double>(
                      initialValue: selectedRadius,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.radar_rounded,
                        ),
                        filled: true,
                        fillColor: colors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusSmall,
                          ),
                          borderSide: BorderSide(
                            color: borderColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusSmall,
                          ),
                          borderSide: BorderSide(
                            color: borderColor,
                          ),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 100,
                          child: Text(
                            '100 metres',
                          ),
                        ),
                        DropdownMenuItem(
                          value: 250,
                          child: Text(
                            '250 metres',
                          ),
                        ),
                        DropdownMenuItem(
                          value: 500,
                          child: Text(
                            '500 metres',
                          ),
                        ),
                        DropdownMenuItem(
                          value: 1000,
                          child: Text(
                            '1 kilometre',
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedRadius = value;
                          });
                        }
                      },
                    ),

                    const SizedBox(
                      height: AppSpacing.extraLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Fixed Create Nudge button
          Container(
            padding: const EdgeInsets.all(
              AppSpacing.standard,
            ),
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border(
                top: BorderSide(
                  color: colors.onSurface.withValues(
                    alpha: 0.18,
                  ),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveNudge,
                  child: const Text(
                    'Create Nudge',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}