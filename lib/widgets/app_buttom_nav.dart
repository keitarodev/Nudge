import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final unselectedColor = theme.colorScheme.onSurfaceVariant;
    final surfaceColor = theme.colorScheme.surface;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: SizedBox(
        height: 90,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Floating navigation bar
            Positioned(
              top: 14,
              left: 0,
              right: 0,
              child: Container(
                height: 62,
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(24),

                  // Only show an outline in dark mode.
                  border: isDarkMode
                      ? Border.all(color: theme.colorScheme.outline, width: 1)
                      : null,

                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withOpacity(
                        isDarkMode ? 0.30 : 0.15,
                      ),
                      blurRadius: isDarkMode ? 20 : 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Home
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onTap(0),
                        behavior: HitTestBehavior.opaque,
                        child: _NavItem(
                          icon: currentIndex == 0
                              ? Icons.home
                              : Icons.home_outlined,
                          label: 'Home',
                          isSelected: currentIndex == 0,
                          selectedColor: primaryColor,
                          unselectedColor: unselectedColor,
                        ),
                      ),
                    ),

                    // Space for floating +
                    const Expanded(child: SizedBox()),

                    // Settings
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onTap(2),
                        behavior: HitTestBehavior.opaque,
                        child: _NavItem(
                          icon: currentIndex == 2
                              ? Icons.settings
                              : Icons.settings_outlined,
                          label: 'Settings',
                          isSelected: currentIndex == 2,
                          selectedColor: primaryColor,
                          unselectedColor: unselectedColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Floating + button
            // Floating + button
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => onTap(1),
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: currentIndex == 1 ? primaryColor : surfaceColor,
                      shape: BoxShape.circle,

                      // Border for both modes
                      border: Border.all(
                        color: isDarkMode
                            ? theme.colorScheme.outline
                            : primaryColor,
                        width: 1.5,
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(
                            currentIndex == 1 ? 0.35 : 0.12,
                          ),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.add,
                      size: 36,
                      color: currentIndex == 1
                          ? theme.colorScheme.onPrimary
                          : primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 25,
          color: isSelected ? selectedColor : unselectedColor,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? selectedColor : unselectedColor,
          ),
        ),
      ],
    );
  }
}
