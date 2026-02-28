import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/dish_model.dart';
import '../cart/cart_bloc.dart';
import '../cart/cart_event.dart';
import 'item_details_bloc.dart';
import 'item_details_event.dart';
import 'item_details_state.dart';

/// Item details page matching the reference design
class ItemDetailsScreen extends StatelessWidget {
  final Dish dish;

  const ItemDetailsScreen({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemDetailsBloc(basePrice: dish.price),
      child: _ItemDetailsBody(dish: dish),
    );
  }
}

class _ItemDetailsBody extends StatelessWidget {
  final Dish dish;

  const _ItemDetailsBody({required this.dish});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Hero image section
                    _buildImageSection(context),

                    // Content section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),

                          // Dish name
                          Text(
                            dish.arabicName,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Description
                          Text(
                            dish.description ??
                                'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها.',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.grey,
                              height: 1.6,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Price and quantity row
                          _buildPriceQuantityRow(context),

                          const SizedBox(height: 24),

                          // Size section
                          _buildSizeSection(context),

                          const SizedBox(height: 20),

                          // Extras section
                          _buildExtrasSection(context),

                          const SizedBox(height: 20),

                          // Type section
                          _buildTypeSection(context),

                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom add-to-cart bar
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  /// Hero image area with back button
  Widget _buildImageSection(BuildContext context) {
    return Stack(
      children: [
        // Image container
        Container(
          width: double.infinity,
          height: 280,
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5F5),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Image.asset(
                dish.imageAsset,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.restaurant,
                    size: 80,
                    color: AppColors.grey,
                  );
                },
              ),
            ),
          ),
        ),

        // Back button (top-right in RTL = top-left visually)
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          right: 16,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.coral,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),

        // Bell icon (top-left in RTL = top-right visually)
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          child: const Icon(
            Icons.notifications_none_outlined,
            color: AppColors.textSecondary,
            size: 28,
          ),
        ),
      ],
    );
  }

  /// Price and quantity controls
  Widget _buildPriceQuantityRow(BuildContext context) {
    return BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Price
            Text(
              '${dish.price.toStringAsFixed(dish.price == dish.price.roundToDouble() ? 0 : 2)} د.ك',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            // Quantity controls
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Decrease
                  _buildQuantityButton(
                    icon: Icons.remove,
                    onTap: () {
                      if (state.quantity > 1) {
                        context.read<ItemDetailsBloc>().add(
                              ItemQuantityChanged(state.quantity - 1),
                            );
                      }
                    },
                  ),

                  // Count
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '${state.quantity}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),

                  // Increase
                  _buildQuantityButton(
                    icon: Icons.add,
                    onTap: () {
                      context.read<ItemDetailsBloc>().add(
                            ItemQuantityChanged(state.quantity + 1),
                          );
                    },
                    isAdd: true,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isAdd = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isAdd ? AppColors.coral : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20,
          color: isAdd ? Colors.white : AppColors.coral,
        ),
      ),
    );
  }

  /// Size section with radio options
  Widget _buildSizeSection(BuildContext context) {
    return BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
      builder: (context, state) {
        return _buildOptionSection(
          title: 'الحجم',
          badge: 'الزامي',
          badgeColor: AppColors.coral,
          children: List.generate(state.sizes.length, (index) {
            return _buildRadioOption(
              name: state.sizes[index].name,
              price: state.sizes[index].price,
              isSelected: state.selectedSizeIndex == index,
              onTap: () {
                context.read<ItemDetailsBloc>().add(ItemSizeSelected(index));
              },
            );
          }),
        );
      },
    );
  }

  /// Extras section with toggle options
  Widget _buildExtrasSection(BuildContext context) {
    return BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
      builder: (context, state) {
        return _buildOptionSection(
          title: 'الإضافات',
          badge: 'اختياري',
          badgeColor: const Color(0xFF4CAF50),
          children: List.generate(state.extras.length, (index) {
            return _buildRadioOption(
              name: state.extras[index].name,
              price: state.extras[index].price,
              isSelected: state.selectedExtras.contains(index),
              onTap: () {
                context.read<ItemDetailsBloc>().add(ItemExtraToggled(index));
              },
            );
          }),
        );
      },
    );
  }

  /// Type section with radio options
  Widget _buildTypeSection(BuildContext context) {
    return BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
      builder: (context, state) {
        return _buildOptionSection(
          title: 'النوع',
          badge: 'الزامي',
          badgeColor: AppColors.coral,
          children: List.generate(state.types.length, (index) {
            return _buildRadioOption(
              name: state.types[index].name,
              price: state.types[index].price,
              isSelected: state.selectedTypeIndex == index,
              onTap: () {
                context.read<ItemDetailsBloc>().add(ItemTypeSelected(index));
              },
            );
          }),
        );
      },
    );
  }

  /// Generic option section with title and badge
  Widget _buildOptionSection({
    required String title,
    required String badge,
    required Color badgeColor,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row with badge
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                badge,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: badgeColor,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Option items
        ...children,
      ],
    );
  }

  /// Single radio option row
  Widget _buildRadioOption({
    required String name,
    required double price,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            // Radio circle
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.coral : const Color(0xFFBDBDBD),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: AppColors.coral,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),

            const SizedBox(width: 12),

            // Name
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            // Price
            Text(
              '${price.toStringAsFixed(2)} د.ك',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Bottom bar with total price and add-to-cart button
  Widget _buildBottomBar(BuildContext context) {
    return BlocBuilder<ItemDetailsBloc, ItemDetailsState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                // Total price
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${state.totalPrice.toStringAsFixed(state.totalPrice == state.totalPrice.roundToDouble() ? 0 : 2)} ج.م',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Add to cart button
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      // Add items to cart (quantity times)
                      for (int i = 0; i < state.quantity; i++) {
                        context.read<CartBloc>().add(CartItemAdded());
                      }
                      // Show confirmation and go back
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'تمت إضافة ${dish.arabicName} إلى السلة',
                            textDirection: TextDirection.rtl,
                          ),
                          backgroundColor: AppColors.coral,
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.coral,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Button text
                          const Text(
                            'إضافه إلي السله',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(width: 10),

                          // Quantity badge
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '${state.quantity}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
