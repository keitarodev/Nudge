import 'package:flutter/material.dart';

import '../../theme/app_sizes.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {

  // This keeps track of which filter is selected
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          // =========================
          // HEADER
          // =========================

          Container(
            color: Colors.white,

            child: SafeArea(
              bottom: false,

              child: Padding(
                padding: const EdgeInsets.all(
                  AppSpacing.large,
                ),

                child: Row(
                  children: [

                    // Home title
                    Expanded(
                      child: Text(
                        'Home',
                        style: AppTextStyles.heading,
                      ),
                    ),

                    // Notification icon
                    Stack(
                      children: [

                        IconButton(
                          onPressed: () {
                            // Notification functionality later
                          },

                          icon: const Icon(
                            Icons.notifications_none_rounded,
                            size: AppSizes.icon,
                          ),
                        ),

                        // Notification dot
                        Positioned(
                          right: 8,
                          top: 8,

                          child: Container(
                            width: 8,
                            height: 8,

                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
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

          // =========================
          // BODY
          // =========================

          Expanded(
            child: Container(
              color: AppColors.lightBackground,

              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(
                    AppSpacing.large,
                  ),

                  child: Column(
                    children: [

                      // =========================
                      // ACTIVE NUDGES CARD
                      // =========================

                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(
                          AppSpacing.large,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                            AppSizes.radiusLarge,
                          ),

                          border: Border.all(
                            color: AppColors.lightAccent,
                          ),
                        ),

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            // Top row
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

                              children: [

                                // Notification circle
                                Container(
                                  width: 56,
                                  height: 56,

                                  decoration:
                                      const BoxDecoration(
                                    color:
                                        AppColors.lightAccent,
                                    shape: BoxShape.circle,
                                  ),

                                  child: const Icon(
                                    Icons
                                        .notifications_none_rounded,
                                    size: 30,
                                  ),
                                ),

                                // Information icon
                                const Icon(
                                  Icons.info_outline,
                                  size: AppSizes.icon,
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: AppSpacing.extraLarge,
                            ),

                            // Active nudges
                            Text(
                              '3 Active Nudges',
                              style: AppTextStyles.heading,
                            ),

                            const SizedBox(
                              height: AppSpacing.micro,
                            ),

                            // Triggered today
                            Text(
                              '1 triggered today',
                              style: AppTextStyles.body,
                            ),

                            const SizedBox(
                              height: AppSpacing.large,
                            ),

                            // Arrive and Leave
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

                              children: [

                                Text(
                                  '2 Arrive',
                                  style: AppTextStyles.body,
                                ),

                                Text(
                                  '1 Leave',
                                  style: AppTextStyles.body,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Smaller space after card
                      const SizedBox(
                        height: AppSpacing.standard,
                      ),

                      // =========================
                      // TODAY
                      // =========================

                      Align(
                        alignment: Alignment.centerLeft,

                        child: Text(
                          'TODAY',
                          style: AppTextStyles.sectionHeading,
                        ),
                      ),

                      const SizedBox(
                        height: AppSpacing.normal,
                      ),

                      // =========================
                      // FILTER BUTTONS
                      // =========================

                      Row(
                        children: [

                          // All button
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedFilter = 'All';
                                });
                              },

                              child: Container(
                                padding:
                                    const EdgeInsets.all(
                                  AppSpacing.normal,
                                ),

                                decoration: BoxDecoration(
                                  color:
                                      selectedFilter == 'All'
                                          ? AppColors
                                              .lightAccent
                                          : Colors.white,

                                  borderRadius:
                                      BorderRadius.circular(
                                    AppSizes.radiusSmall,
                                  ),

                                  border: Border.all(
                                    color: AppColors.lightAccent,
                                  ),
                                ),

                                child: Text(
                                  'All',
                                  textAlign:
                                      TextAlign.center,

                                  style:
                                      AppTextStyles.body
                                          .copyWith(
                                    color:
                                        selectedFilter ==
                                                'All'
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: AppSpacing.small,
                          ),

                          // Arrive button
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedFilter =
                                      'Arrive';
                                });
                              },

                              child: Container(
                                padding:
                                    const EdgeInsets.all(
                                  AppSpacing.normal,
                                ),

                                decoration: BoxDecoration(
                                  color:
                                      selectedFilter ==
                                              'Arrive'
                                          ? AppColors
                                              .lightAccent
                                          : Colors.white,

                                  borderRadius:
                                      BorderRadius.circular(
                                    AppSizes.radiusSmall,
                                  ),

                                  border: Border.all(
                                    color: AppColors.lightAccent,
                                  ),
                                ),

                                child: Text(
                                  'Arrive',
                                  textAlign:
                                      TextAlign.center,

                                  style:
                                      AppTextStyles.body
                                          .copyWith(
                                    color:
                                        selectedFilter ==
                                                'Arrive'
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: AppSpacing.small,
                          ),

                          // Leave button
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedFilter =
                                      'Leave';
                                });
                              },

                              child: Container(
                                padding:
                                    const EdgeInsets.all(
                                  AppSpacing.normal,
                                ),

                                decoration: BoxDecoration(
                                  color:
                                      selectedFilter ==
                                              'Leave'
                                          ? AppColors
                                              .lightAccent
                                          : Colors.white,

                                  borderRadius:
                                      BorderRadius.circular(
                                    AppSizes.radiusSmall,
                                  ),

                                  border: Border.all(
                                    color: AppColors.lightAccent,
                                  ),
                                ),

                                child: Text(
                                  'Leave',
                                  textAlign:
                                      TextAlign.center,

                                  style:
                                      AppTextStyles.body
                                          .copyWith(
                                    color:
                                        selectedFilter ==
                                                'Leave'
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: AppSpacing.normal,
                      ),

                      // =========================
                      // NUDGE CARDS
                      // =========================

                      // Buy medicine
                      if (selectedFilter == 'All' ||
                          selectedFilter == 'Arrive')
                        Container(
                          width: double.infinity,

                          padding: const EdgeInsets.all(
                            AppSpacing.standard,
                          ),

                          margin: const EdgeInsets.only(
                            bottom: AppSpacing.normal,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius:
                                BorderRadius.circular(
                              AppSizes.radiusLarge,
                            ),

                            border: Border.all(
                              color: AppColors.lightAccent,
                            ),
                          ),

                          child: Row(
                            children: [

                              // Icon
                              Container(
                                width: 56,
                                height: 56,

                                decoration:
                                    const BoxDecoration(
                                  color:
                                      AppColors.lightAccent,
                                  shape: BoxShape.circle,
                                ),

                                child: const Icon(
                                  Icons.medication_outlined,
                                  size: 28,
                                ),
                              ),

                              const SizedBox(
                                width: AppSpacing.standard,
                              ),

                              // Text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                  children: [

                                    Text(
                                      'Buy medicine',
                                      style:
                                          AppTextStyles
                                              .cardTitle,
                                    ),

                                    const SizedBox(
                                      height:
                                          AppSpacing.micro,
                                    ),

                                    Text(
                                      'Pharmacy · When I arrive',
                                      style:
                                          AppTextStyles.body,
                                    ),
                                  ],
                                ),
                              ),

                              // Arrow
                              const Icon(
                                Icons.chevron_right,
                                size: AppSizes.icon,
                              ),
                            ],
                          ),
                        ),

                      // Submit assignment
                      if (selectedFilter == 'All' ||
                          selectedFilter == 'Arrive')
                        Container(
                          width: double.infinity,

                          padding: const EdgeInsets.all(
                            AppSpacing.standard,
                          ),

                          margin: const EdgeInsets.only(
                            bottom: AppSpacing.normal,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius:
                                BorderRadius.circular(
                              AppSizes.radiusLarge,
                            ),

                            border: Border.all(
                              color: AppColors.lightAccent,
                            ),
                          ),

                          child: Row(
                            children: [

                              // Icon
                              Container(
                                width: 56,
                                height: 56,

                                decoration:
                                    const BoxDecoration(
                                  color:
                                      AppColors.lightAccent,
                                  shape: BoxShape.circle,
                                ),

                                child: const Icon(
                                  Icons.menu_book_outlined,
                                  size: 28,
                                ),
                              ),

                              const SizedBox(
                                width: AppSpacing.standard,
                              ),

                              // Text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                  children: [

                                    Text(
                                      'Submit assignment',
                                      style:
                                          AppTextStyles
                                              .cardTitle,
                                    ),

                                    const SizedBox(
                                      height:
                                          AppSpacing.micro,
                                    ),

                                    Text(
                                      'University · When I arrive',
                                      style:
                                          AppTextStyles.body,
                                    ),
                                  ],
                                ),
                              ),

                              // Arrow
                              const Icon(
                                Icons.chevron_right,
                                size: AppSizes.icon,
                              ),
                            ],
                          ),
                        ),

                      // Buy milk
                      if (selectedFilter == 'All' ||
                          selectedFilter == 'Leave')
                        Container(
                          width: double.infinity,

                          padding: const EdgeInsets.all(
                            AppSpacing.standard,
                          ),

                          margin: const EdgeInsets.only(
                            bottom: AppSpacing.normal,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius:
                                BorderRadius.circular(
                              AppSizes.radiusLarge,
                            ),

                            border: Border.all(
                              color: AppColors.lightAccent,
                            ),
                          ),

                          child: Row(
                            children: [

                              // Icon
                              Container(
                                width: 56,
                                height: 56,

                                decoration:
                                    const BoxDecoration(
                                  color:
                                      AppColors.lightAccent,
                                  shape: BoxShape.circle,
                                ),

                                child: const Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 28,
                                ),
                              ),

                              const SizedBox(
                                width: AppSpacing.standard,
                              ),

                              // Text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                  children: [

                                    Text(
                                      'Buy milk',
                                      style:
                                          AppTextStyles
                                              .cardTitle,
                                    ),

                                    const SizedBox(
                                      height:
                                          AppSpacing.micro,
                                    ),

                                    Text(
                                      'Supermarket · When I leave',
                                      style:
                                          AppTextStyles.body,
                                    ),
                                  ],
                                ),
                              ),

                              // Arrow
                              const Icon(
                                Icons.chevron_right,
                                size: AppSizes.icon,
                              ),
                            ],
                          ),
                        ),
                    ],
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