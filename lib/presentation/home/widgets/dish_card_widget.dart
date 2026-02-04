import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/dish_model.dart';

/// Card widget for displaying a dish with Arabic design - LARGER FONTS, FIXED OVERFLOW
class DishCardWidget extends StatelessWidget {
  final Dish dish;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const DishCardWidget({
    super.key,
    required this.dish,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        height: 230, // Increased from 210 to fix overflow
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFF0F0), // Very light pink
              const Color(0xFFEFBDBD), // Light pink (user's color)
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Main content
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 70, 12, 12),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Dish name in Arabic - BIGGER
                    Text(
                      dish.arabicName,
                      style: const TextStyle(
                        fontSize: 16, // Larger
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    // Category tag with fire icon
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            size: 14,
                            color: AppColors.coral,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            dish.categoryDisplayName,
                            style: const TextStyle(
                              fontSize: 12, // Larger
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Rating row - BIGGER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '(${dish.reviewCount}+)',
                          style: const TextStyle(
                            fontSize: 12, // Larger
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          dish.rating.toString(),
                          style: const TextStyle(
                            fontSize: 14, // Larger
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: AppColors.starYellow,
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Price row with cart button - BIGGER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Cart button
                        GestureDetector(
                          onTap: onAddToCart,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 20,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        // Price - BIGGER
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'ج.م',
                              style: TextStyle(
                                fontSize: 12, // Larger
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              dish.price.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 20, // Larger
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Floating food image
            Positioned(
              top: -25,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: Image.asset(
                    dish.imageAsset,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.greyLight,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.restaurant,
                          size: 40,
                          color: AppColors.grey,
                        ),
                      );
                    },
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
