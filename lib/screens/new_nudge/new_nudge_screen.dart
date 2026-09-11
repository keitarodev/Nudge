import 'package:flutter/material.dart';

import '../../data/app_data.dart';
import '../../models/nudge.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import 'choose_place_screen.dart';
import 'nudge_saved_screen.dart';
import 'review_nudge_screen.dart';
import 'trigger_screen.dart';
import 'what_screen.dart';

class NewNudgeScreen extends StatefulWidget {
  const NewNudgeScreen({super.key});

  @override
  State<NewNudgeScreen> createState() {
    return _NewNudgeScreenState();
  }
}

class _NewNudgeScreenState extends State<NewNudgeScreen> {
  int currentStep = 0;

  String title = '';
  String? selectedCategory;
  NudgeTrigger selectedTrigger = NudgeTrigger.arrive;
  String placeName = '';
  double selectedRadius = 250;

  Nudge? savedNudge;

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  bool _validateCurrentStep() {
    if (currentStep == 0) {
      if (title.trim().isEmpty) {
        _showMessage('Please enter a reminder.');
        return false;
      }

      if (selectedCategory == null) {
        _showMessage('Please select a category.');
        return false;
      }
    }

    if (currentStep == 2 && placeName.trim().isEmpty) {
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
      placeId: placeName,
      trigger: selectedTrigger,
      radius: selectedRadius.toInt(),
      status: 'active',
      createdAt: DateTime.now(),
      lastTriggeredAt: null,
    );
  }

  void _handlePrimaryButton() {
    if (!_validateCurrentStep()) {
      return;
    }

    if (currentStep < 3) {
      setState(() {
        currentStep++;
      });
    } else {
      final nudge = _createNudge();

      // Save the new Nudge to the shared AppData.
      AppData.nudges.add(nudge);

      setState(() {
        savedNudge = nudge;
      });
    }
  }

  void _goBack() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void _resetFlow() {
    setState(() {
      currentStep = 0;
      title = '';
      selectedCategory = null;
      selectedTrigger = NudgeTrigger.arrive;
      placeName = '';
      selectedRadius = 250;
      savedNudge = null;
    });
  }

  Widget _buildCurrentStep() {
    if (currentStep == 0) {
      return WhatScreen(
        title: title,
        selectedCategory: selectedCategory,
        categories: AppData.categories,
        onTitleChanged: (value) {
          setState(() {
            title = value;
          });
        },
        onCategoryChanged: (value) {
          setState(() {
            selectedCategory = value;
          });
        },
      );
    }

    if (currentStep == 1) {
      return TriggerScreen(
        selectedTrigger: selectedTrigger,
        onTriggerChanged: (value) {
          setState(() {
            selectedTrigger = value;
          });
        },
      );
    }

    if (currentStep == 2) {
      return ChoosePlaceScreen(
        placeName: placeName,
        selectedRadius: selectedRadius,
        places: AppData.places,
        onPlaceChanged: (value) {
          setState(() {
            placeName = value;
          });
        },
        onRadiusChanged: (value) {
          setState(() {
            selectedRadius = value;
          });
        },
      );
    }

    return ReviewNudgeScreen(
      nudge: _createNudge(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (savedNudge != null) {
      return Scaffold(
        body: SafeArea(
          child: NudgeSavedScreen(
            nudge: savedNudge!,
            onCreateAnother: _resetFlow,
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: colorScheme.surface,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.large,
                  AppSpacing.large,
                  AppSpacing.large,
                  AppSpacing.standard,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Nudge',
                      style: textTheme.displayLarge,
                    ),
                    const SizedBox(height: AppSpacing.normal),
                    Row(
                      children: [
                        Text(
                          'Step ${currentStep + 1} of 4',
                          style: textTheme.bodyLarge,
                        ),
                        const SizedBox(width: AppSpacing.standard),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: (currentStep + 1) / 4,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusSmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: _buildCurrentStep(),
          ),

          Container(
            padding: const EdgeInsets.all(
              AppSpacing.standard,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: colorScheme.outlineVariant,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  if (currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _goBack,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.standard,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusSmall,
                            ),
                          ),
                        ),
                        child: const Text('Back'),
                      ),
                    ),

                  if (currentStep > 0)
                    const SizedBox(
                      width: AppSpacing.normal,
                    ),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: _handlePrimaryButton,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.standard,
                        ),
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onSurface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusSmall,
                          ),
                        ),
                      ),
                      child: Text(
                        currentStep == 3
                            ? 'Save Nudge'
                            : 'Continue',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}