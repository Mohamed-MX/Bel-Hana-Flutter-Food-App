import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/category_model.dart';

/// Horizontal scrollable category chips with images - each with its own color
class CategoryChipsWidget extends StatelessWidget {
  final List<FoodCategory> categories;
  final int selectedIndex;
  final ValueChanged<int>? onSelected;

  const CategoryChipsWidget({
    super.key,
    required this.categories,
    required this.selectedIndex,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemCount: categories.length,
          separatorBuilder: (context, index) => const SizedBox(width: 14),
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = index == selectedIndex;
            
            return GestureDetector(
              onTap: () => onSelected?.call(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image container with CUSTOM background color per category
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      // Use the category's own backgroundColor
                      color: category.backgroundColor,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected 
                            ? AppColors.coral 
                            : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          category.imageAsset,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.restaurant,
                              size: 32,
                              color: AppColors.grey,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Arabic category name - LARGER FONT
                  Text(
                    category.arabicName,
                    style: TextStyle(
                      color: isSelected 
                          ? AppColors.coral 
                          : AppColors.textPrimary,
                      fontWeight: isSelected 
                          ? FontWeight.bold 
                          : FontWeight.w500,
                      fontSize: 14, // Increased from 11
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
