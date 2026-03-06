import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/dish_model.dart';
import '../../favorites/favorites_bloc.dart';
import '../../favorites/favorites_event.dart';
import '../../favorites/favorites_state.dart';

/// Card widget for displaying a dish with Arabic design - with heart favourite button
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
            // Top: Light pink container with food image + heart icon
            BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, favState) {
                final isFav = favState.isFavorite(dish.id);
                return Stack(
                  children: [
                    // Pink image container
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

                    // Heart button — top right
                    Positioned(
                      top: 6,
                      right: 6,
                      child: GestureDetector(
                        onTap: () {
                          if (isFav) {
                            context
                                .read<FavoritesBloc>()
                                .add(FavoriteRemoved(dish.id));
                          } else {
                            context
                                .read<FavoritesBloc>()
                                .add(FavoriteAdded(dish));
                          }
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            size: 18,
                            color: isFav ? AppColors.coral : AppColors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
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
                            fontSize: 16,
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
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Rating row
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
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${dish.reviewCount}+)',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Price
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${dish.price.toInt()}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'ج.م',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Cart button — bottom left, special corner rounding
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
