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
      child: SizedBox(
        width: 180,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top: Light pink container with food image inside
            Container(
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                color: const Color(0xFFFDE8E8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(
                    dish.imageAsset,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
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

            // Bottom: White area with text content
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Text content - right aligned (RTL)
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dish name
                        Text(
                          dish.arabicName,
                          style: const TextStyle(
                            fontSize: 16, // Larger
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Category with icon
                        Row(
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
                        const SizedBox(height: 4),
                        // Rating row - BIGGER
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 18,
                              color: AppColors.starYellow,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              dish.rating.toString(),
                              style: const TextStyle(
                                fontSize: 14, // Larger
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${dish.reviewCount}+)',
                              style: const TextStyle(
                                fontSize: 12, // Larger
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Price - BIGGER
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${dish.price.toInt()}',
                              style: const TextStyle(
                                fontSize: 20, // Larger
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'ج.م',
                              style: TextStyle(
                                fontSize: 12, // Larger
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Cart button - bottom left, special corner rounding
                  // Rounded on top-right and bottom-left ONLY
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: onAddToCart,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          color: AppColors.coral,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(14),
                            bottomLeft: Radius.circular(14),
                          ),
                        ),
                        child: const Icon(
                          Icons.add_shopping_cart,
                          size: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
