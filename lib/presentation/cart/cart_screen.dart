import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import 'cart_bloc.dart';
import 'cart_event.dart';
import 'cart_item_model.dart';
import 'cart_state.dart';

/// Cart Screen - عربة التسوق
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state.items.isEmpty) {
                      return _buildEmptyCart();
                    }
                    return _buildCartContent(context, state);
                  },
                ),
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state.items.isEmpty) return const SizedBox.shrink();
                  return _buildBottomBar(context, state);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Header: bell (right-RTL), title center, back arrow (left-RTL)
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          // Bell icon (right in RTL = first child)
          const Icon(
            Icons.notifications_none_outlined,
            color: AppColors.textSecondary,
            size: 30,
          ),
          // Title centered
          const Expanded(
            child: Center(
              child: Text(
                'عربة التسوق',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          // Coral circle back arrow (left in RTL = last child)
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: AppColors.coral,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Empty cart placeholder
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: AppColors.coral.withValues(alpha: 0.4)),
          const SizedBox(height: 16),
          const Text(
            'السلة فارغة',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'أضف أصنافاً من الصفحة الرئيسية',
            style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  /// Main scrollable cart content
  Widget _buildCartContent(BuildContext context, CartState state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Items list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: state.items.length,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
              color: Color(0xFFEEEEEE),
            ),
            itemBuilder: (context, index) =>
                _buildCartItem(context, state.items[index]),
          ),

          const SizedBox(height: 16),

          // Payment summary
          _buildPaymentSummary(state),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  /// Single cart item row: image (right-RTL), text + controls, price
  Widget _buildCartItem(BuildContext context, CartItemModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food image (right in RTL)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              item.imageAsset,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFFFDE8E8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.restaurant, color: AppColors.coral),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Text and controls
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  item.arabicName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 6),

                // Quantity controls + price row
                Row(
                  children: [
                    // Quantity controls
                    _buildQtyControl(
                      icon: Icons.add,
                      onTap: () => context
                          .read<CartBloc>()
                          .add(CartItemIncremented(item.dishId)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    _buildQtyControl(
                      icon: Icons.remove,
                      onTap: () => context
                          .read<CartBloc>()
                          .add(CartItemDecremented(item.dishId)),
                    ),

                    const Spacer(),

                    // Price
                    Text(
                      '${item.price.toStringAsFixed(2)} ج.م',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyControl({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFDDDDDD), width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: AppColors.coral),
      ),
    );
  }

  /// Payment summary section
  Widget _buildPaymentSummary(CartState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ملخص الدفع',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow('المجموع الفرعي', '${state.subtotal.toStringAsFixed(2)} ج.م', bold: false),
          const SizedBox(height: 8),
          _buildSummaryRow('توصيل', '${state.deliveryFee.toStringAsFixed(2)} ج.م', bold: false),
          const Divider(height: 20, color: Color(0xFFEEEEEE)),
          _buildSummaryRow('المبلغ الإجمالي', '${state.total.toStringAsFixed(2)} ج.م', bold: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {required bool bold}) {
    final style = TextStyle(
      fontSize: bold ? 16 : 14,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: bold ? AppColors.textPrimary : AppColors.textSecondary,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }

  /// Sticky bottom bar: total + checkout button
  Widget _buildBottomBar(BuildContext context, CartState state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Total
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'الإجمالي:',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              Text(
                '\$${state.total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.coral,
                ),
              ),
            ],
          ),

          const SizedBox(width: 16),

          // Checkout Button
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // TODO: wire to checkout flow
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.coral,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'إتمام عملية الشراء',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
