import 'package:flutter/material.dart';
import 'package:nudge/screens/notifications/notifications_screen.dart';

import '../../data/app_data.dart';
import '../../models/nudge.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

import '../history/history_screen.dart';
import 'edit_nudge_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Current trigger filter.
  // null means all triggers.
  NudgeTrigger? _selectedTrigger;

  // Current category filter.
  // null means all categories.
  String? _selectedCategory;

  // ==========================================
  // EDIT NUDGE
  // ==========================================
  Future<void> editNudge(Nudge nudge) async {
    final updatedNudge = await showModalBottomSheet<Nudge>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return EditNudgeBottomSheet(
          nudge: nudge,
          categories: AppData.categories,
          places: AppData.places,
        );
      },
    );

    // Update Home after saving
    if (updatedNudge != null) {
      setState(() {
        final index = AppData.nudges.indexWhere(
          (item) => item.id == updatedNudge.id,
        );

        if (index != -1) {
          AppData.nudges[index] = updatedNudge;
        }
      });
    }
  }

  // ==========================================
  // COMPLETE NUDGE
  // ==========================================
  void completeNudge(Nudge nudge) {
    setState(() {
      AppData.nudges.removeWhere(
        (item) => item.id == nudge.id,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nudge completed'),
      ),
    );
  }

  // ==========================================
  // SELECT TRIGGER
  // ==========================================
  void _selectTrigger(NudgeTrigger trigger) {
    setState(() {
      // Tap the same trigger again to show all triggers.
      if (_selectedTrigger == trigger) {
        _selectedTrigger = null;
      } else {
        _selectedTrigger = trigger;
      }
    });
  }

  // ==========================================
  // SELECT CATEGORY
  // ==========================================
  void _selectCategory(String? categoryId) {
    setState(() {
      _selectedCategory = categoryId;
    });
  }

  // ==========================================
  // GET FILTERED NUDGES
  // ==========================================
  List<Nudge> _getFilteredNudges() {
    List<Nudge> filtered = AppData.nudges.where((nudge) {
      // Trigger filter
      if (_selectedTrigger != null &&
          nudge.trigger != _selectedTrigger) {
        return false;
      }

      // Category filter
      if (_selectedCategory != null &&
          nudge.categoryId != _selectedCategory) {
        return false;
      }

      return true;
    }).toList();

    return filtered;
  }

  // ==========================================
  // GET CATEGORY NAME
  // ==========================================
  String _getCategoryName(String categoryId) {
    final category = AppData.categories.firstWhere(
      (item) => item.id == categoryId,
    );

    return category.name;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ==========================================
    // TRIGGER COUNTS
    // ==========================================
    final arriveCount = AppData.nudges
        .where(
          (nudge) =>
              nudge.trigger == NudgeTrigger.arrive,
        )
        .length;

    final leaveCount = AppData.nudges
        .where(
          (nudge) =>
              nudge.trigger == NudgeTrigger.leave,
        )
        .length;

    final nearbyCount = AppData.nudges
        .where(
          (nudge) =>
              nudge.trigger == NudgeTrigger.nearby,
        )
        .length;

    // ==========================================
    // FILTERED NUDGES
    // ==========================================
    final filteredNudges = _getFilteredNudges();

    return Scaffold(
      backgroundColor:
          theme.scaffoldBackgroundColor,

      // ==========================================
      // HEADER
      // ==========================================
      appBar: AppBar(
        backgroundColor:
            theme.scaffoldBackgroundColor,

        elevation: 0,

        scrolledUnderElevation: 0,

        centerTitle: false,

        titleSpacing:
            AppSpacing.large,

        // Logo + name
        title: Transform.translate(
          offset: const Offset(0, -2),

          child: Row(
            mainAxisSize:
                MainAxisSize.min,

            children: [
              Image.asset(
                'assets/images/nudge_logo-01.png',

                width: 40,
                height: 40,

                fit: BoxFit.contain,
              ),

              const SizedBox(
                width:
                    AppSpacing.small,
              ),

              Text(
                'nudge',

                style:
                    AppTextStyles.heading,
              ),
            ],
          ),
        ),

        // Header buttons
        actions: [
          // ==========================================
          // HISTORY
          // ==========================================
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const HistoryScreen(),
                ),
              );
            },

            icon: const Icon(
              Icons.history_outlined,
            ),
          ),

          // ==========================================
          // NOTIFICATIONS
          // ==========================================
          Padding(
            padding: const EdgeInsets.only(
              right:
                  AppSpacing.large,
            ),

            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const NotificationsScreen(),
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.notifications_none_outlined,
                  ),
                ),

                // Notification red dot
                Positioned(
                  right: 10,
                  top: 10,

                  child: Container(
                    width: 8,
                    height: 8,

                    decoration:
                        BoxDecoration(
                      color: theme
                          .colorScheme
                          .error,

                      shape:
                          BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ==========================================
      // MAIN CONTENT
      // ==========================================
      body: ListView(
        padding:
            const EdgeInsets.fromLTRB(
          AppSpacing.large,
          AppSpacing.normal,
          AppSpacing.large,
          AppSpacing.large,
        ),

        children: [
          // ==========================================
          // ACTIVE NUDGES SUMMARY
          // ==========================================
          Container(
            padding:
                const EdgeInsets.all(
              AppSpacing.large,
            ),

            decoration:
                BoxDecoration(
              color:
                  theme.colorScheme.primary,

              borderRadius:
                  BorderRadius.circular(
                AppSizes.radiusLarge,
              ),
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                // Total nudges
                Text(
                  '${AppData.nudges.length} Active Nudges',

                  style: const TextStyle(
                    color:
                        AppColors.dark,

                    fontSize: 28,

                    fontWeight:
                        FontWeight.w800,
                  ),
                ),

                const SizedBox(
                  height:
                      AppSpacing.small,
                ),

                // Description
                Text(
                  'Your location reminders are active',

                  style: TextStyle(
                    color:
                        AppColors.dark
                            .withValues(
                      alpha: 0.7,
                    ),

                    fontSize: 14,
                  ),
                ),

                const SizedBox(
                  height:
                      AppSpacing.large,
                ),

                // ==========================================
                // TRIGGER STATISTICS
                // ==========================================
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  crossAxisAlignment:
                      CrossAxisAlignment.center,

                  children: [
                    // ARRIVE
                    Expanded(
                      child:
                          _buildSummaryStat(
                        value:
                            arriveCount.toString(),

                        label:
                            'ARRIVE',

                        trigger:
                            NudgeTrigger.arrive,
                      ),
                    ),

                    Container(
                      width: 1,
                      height: 32,

                      color:
                          AppColors.dark
                              .withValues(
                        alpha: 0.18,
                      ),
                    ),

                    // LEAVE
                    Expanded(
                      child:
                          _buildSummaryStat(
                        value:
                            leaveCount.toString(),

                        label:
                            'LEAVE',

                        trigger:
                            NudgeTrigger.leave,
                      ),
                    ),

                    Container(
                      width: 1,
                      height: 32,

                      color:
                          AppColors.dark
                              .withValues(
                        alpha: 0.18,
                      ),
                    ),

                    // NEARBY
                    Expanded(
                      child:
                          _buildSummaryStat(
                        value:
                            nearbyCount.toString(),

                        label:
                            'NEARBY',

                        trigger:
                            NudgeTrigger.nearby,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(
            height:
                AppSpacing.large,
          ),

          // ==========================================
          // CATEGORY CHIPS
          // ==========================================
          SingleChildScrollView(
            scrollDirection:
                Axis.horizontal,

            child: Row(
              children: [
                // ALL
                _buildCategoryChip(
                  context: context,

                  label: 'All',

                  categoryId: null,
                ),

                const SizedBox(
                  width:
                      AppSpacing.small,
                ),

                // CATEGORIES
                for (
                  int i = 0;
                  i <
                      AppData
                          .categories
                          .length;
                  i++
                ) ...[
                  _buildCategoryChip(
                    context:
                        context,

                    label:
                        AppData
                            .categories[i]
                            .name,

                    categoryId:
                        AppData
                            .categories[i]
                            .id,
                  ),

                  if (i !=
                      AppData
                              .categories
                              .length -
                          1)
                    const SizedBox(
                      width:
                          AppSpacing.small,
                    ),
                ],
              ],
            ),
          ),

          const SizedBox(
            height:
                AppSpacing.normal,
          ),

          // ==========================================
          // FILTER INFORMATION
          // ==========================================
          if (_selectedTrigger != null ||
              _selectedCategory != null)
            Padding(
              padding:
                  const EdgeInsets.only(
                bottom:
                    AppSpacing.normal,
              ),

              child: Row(
                children: [
                  Icon(
                    Icons.filter_alt_outlined,

                    size: 18,

                    color:
                        theme
                            .colorScheme
                            .primary,
                  ),

                  const SizedBox(
                    width:
                        AppSpacing.small,
                  ),

                  Expanded(
                    child: Text(
                      _getFilterText(),

                      style: theme
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                        color: theme
                            .colorScheme
                            .onSurfaceVariant,

                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // ==========================================
          // EMPTY STATE
          // ==========================================
          if (filteredNudges.isEmpty)
            _buildEmptyNudgeState(
              context,
            ),

          // ==========================================
          // NUDGE LIST
          // ==========================================
          for (
            final nudge
                in filteredNudges
          )
            _buildNudgeCard(
              context,
              nudge,
            ),
        ],
      ),
    );
  }

  // ==========================================
  // SUMMARY STAT
  // ==========================================
  Widget _buildSummaryStat({
    required String value,
    required String label,
    required NudgeTrigger trigger,
  }) {
    final bool isSelected =
        _selectedTrigger ==
            trigger;

    return InkWell(
      onTap: () {
        _selectTrigger(
          trigger,
        );
      },

      borderRadius:
          BorderRadius.circular(
        AppSizes.radiusSmall,
      ),

      child: Container(
        padding:
            const EdgeInsets.symmetric(
          vertical:
              AppSpacing.small,

          horizontal:
              AppSpacing.small,
        ),

        decoration:
            BoxDecoration(
          color: isSelected
              ? AppColors.dark
                  .withValues(
                  alpha: 0.10,
                )
              : Colors.transparent,

          borderRadius:
              BorderRadius.circular(
            AppSizes.radiusSmall,
          ),
        ),

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,

          crossAxisAlignment:
              CrossAxisAlignment.baseline,

          textBaseline:
              TextBaseline.alphabetic,

          children: [
            // Number
            Text(
              value,

              style: const TextStyle(
                color:
                    AppColors.dark,

                fontSize: 26,

                fontWeight:
                    FontWeight.w800,
              ),
            ),

            const SizedBox(
              width: 8,
            ),

            // Label
            Flexible(
              child: Text(
                label,

                style: TextStyle(
                  color:
                      AppColors.dark
                          .withValues(
                    alpha: 0.65,
                  ),

                  fontSize: 11,

                  fontWeight:
                      FontWeight.w800,

                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // CATEGORY CHIP
  // ==========================================
  Widget _buildCategoryChip({
    required BuildContext context,
    required String label,
    required String? categoryId,
  }) {
    final theme =
        Theme.of(context);

    final bool isSelected =
        _selectedCategory ==
            categoryId;

    return GestureDetector(
      onTap: () {
        _selectCategory(
          categoryId,
        );
      },

      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal:
              AppSpacing.normal,

          vertical:
              AppSpacing.small,
        ),

        decoration:
            BoxDecoration(
          color: isSelected
              ? theme
                  .colorScheme
                  .primary
              : theme
                  .colorScheme
                  .surface,

          borderRadius:
              BorderRadius.circular(
            AppSizes.radiusSmall,
          ),

          border:
              Border.all(
            color: isSelected
                ? theme
                    .colorScheme
                    .primary
                : theme
                    .colorScheme
                    .outlineVariant,
          ),
        ),

        child: Text(
          label,

          style: theme
              .textTheme
              .bodySmall
              ?.copyWith(
            color: isSelected
                ? AppColors.dark
                : theme
                    .colorScheme
                    .onSurface,

            fontWeight:
                FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // ==========================================
  // FILTER TEXT
  // ==========================================
  String _getFilterText() {
    String triggerText = '';

    if (_selectedTrigger != null) {
      triggerText =
          _selectedTrigger!.label;
    }

    String categoryText = '';

    if (_selectedCategory != null) {
      categoryText =
          _getCategoryName(
        _selectedCategory!,
      );
    }

    if (triggerText.isNotEmpty &&
        categoryText.isNotEmpty) {
      return '$triggerText · $categoryText';
    }

    if (triggerText.isNotEmpty) {
      return triggerText;
    }

    if (categoryText.isNotEmpty) {
      return categoryText;
    }

    return '';
  }

  // ==========================================
  // EMPTY STATE
  // ==========================================
  Widget _buildEmptyNudgeState(
    BuildContext context,
  ) {
    final theme =
        Theme.of(context);

    String message =
        'No nudges found';

    if (_selectedTrigger != null &&
        _selectedCategory != null) {
      message =
          'No ${_getCategoryName(_selectedCategory!)} '
          'nudges for '
          '${_selectedTrigger!.label.toLowerCase()}';
    } else if (_selectedTrigger != null) {
      message =
          'No nudges for '
          '${_selectedTrigger!.label.toLowerCase()}';
    } else if (_selectedCategory != null) {
      message =
          'No ${_getCategoryName(_selectedCategory!)} nudges';
    }

    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical:
            AppSpacing.extraLarge,
      ),

      child: Column(
        children: [
          Icon(
            Icons
                .notifications_none_rounded,

            size: 48,

            color:
                theme.colorScheme.outline,
          ),

          const SizedBox(
            height:
                AppSpacing.normal,
          ),

          Text(
            message,

            textAlign:
                TextAlign.center,

            style:
                AppTextStyles.body.copyWith(
              color: theme
                  .colorScheme
                  .onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // NUDGE CARD
  // ==========================================
  Widget _buildNudgeCard(
    BuildContext context,
    Nudge nudge,
  ) {
    final theme =
        Theme.of(context);

    // Find category
    final category =
        AppData.categories.firstWhere(
      (item) =>
          item.id ==
          nudge.categoryId,
    );

    // Find place
    final place =
        AppData.places.firstWhere(
      (item) =>
          item.id ==
          nudge.placeId,
    );

    return Dismissible(
      // Unique key
      key: Key(nudge.id),

      // Swipe right to left
      direction:
          DismissDirection.endToStart,

      // Complete background
      background: Container(
        margin:
            const EdgeInsets.only(
          bottom:
              AppSpacing.standard,
        ),

        padding:
            const EdgeInsets.only(
          right:
              AppSpacing.large,
        ),

        decoration:
            BoxDecoration(
          color:
              theme.colorScheme.primary,

          borderRadius:
              BorderRadius.circular(
            AppSizes.radiusLarge,
          ),
        ),

        alignment:
            Alignment.centerRight,

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.end,

          children: [
            Icon(
              Icons.check_rounded,

              color:
                  AppColors.dark,
            ),

            const SizedBox(
              width:
                  AppSpacing.small,
            ),

            Text(
              'Complete',

              style: TextStyle(
                color:
                    AppColors.dark,

                fontWeight:
                    FontWeight.w700,
              ),
            ),
          ],
        ),
      ),

      // Complete Nudge
      onDismissed:
          (direction) {
        completeNudge(
          nudge,
        );
      },

      // Card
      child: Card(
        margin:
            const EdgeInsets.only(
          bottom:
              AppSpacing.standard,
        ),

        elevation: 0,

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(
            AppSizes.radiusLarge,
          ),

          side: BorderSide(
            color: theme
                .colorScheme
                .outlineVariant,
          ),
        ),

        child: InkWell(
          borderRadius:
              BorderRadius.circular(
            AppSizes.radiusLarge,
          ),

          onTap: () {
            editNudge(
              nudge,
            );
          },

          child: Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal:
                  AppSpacing.standard,

              vertical:
                  AppSpacing.standard,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                // ==========================================
                // TITLE + CATEGORY
                // ==========================================
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.center,

                  children: [
                    Expanded(
                      child: Text(
                        nudge.title,

                        maxLines: 1,

                        overflow:
                            TextOverflow.ellipsis,

                        style:
                            AppTextStyles
                                .cardTitle,
                      ),
                    ),

                    const SizedBox(
                      width:
                          AppSpacing.small,
                    ),

                    Text(
                      category.name,

                      style: theme
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                        fontWeight:
                            FontWeight.w700,

                        color: theme
                            .colorScheme
                            .secondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height:
                      AppSpacing.small,
                ),

                // ==========================================
                // PLACE + TRIGGER + RADIUS
                // ==========================================
                Text(
                  '${place.name} · '
                  '${nudge.trigger.label} · '
                  '${nudge.radius} m',

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style: theme
                      .textTheme
                      .bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}