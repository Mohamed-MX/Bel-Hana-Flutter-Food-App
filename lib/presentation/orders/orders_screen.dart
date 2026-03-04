import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_assets.dart';

/// Orders Screen - shows Track Order content
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header (no back button since this is a tab)
                      _buildHeader(),

                      // Delivery Illustration
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Image.asset(
                          AppAssets.deliveryIllustration,
                          height: 220,
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Delivery time text
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              'سيتم توصيل طعامك خلال',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.greyDark,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '20 - 15',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'دقيقة',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.coral,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Divider
                      const Divider(
                        color: Color(0xFFE0E0E0),
                        thickness: 1,
                        indent: 24,
                        endIndent: 24,
                      ),

                      const SizedBox(height: 12),

                      // Order Info Section Header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'معلومات الطلب',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Food Item Card
                      _buildFoodItemCard(),

                      const SizedBox(height: 20),

                      _buildOrderDetailsList(),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Bottom Buttons
              _buildBottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  /// Header: title on right, bell on left (no back button for tab)
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          // Title (right side in RTL = first child)
          Expanded(
            child: Text(
              'تتبع الطلب',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Bell icon (left side in RTL = last child)
          const Icon(
            Icons.notifications_none_outlined,
            color: AppColors.textSecondary,
            size: 35,
          ),
        ],
      ),
    );
  }

  /// Food item card: image on right, text on left
  Widget _buildFoodItemCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Pasta image (right side visually = first in RTL Row)
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                AppAssets.pastaDish,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'معكرونه بالصوص و قطع بانية حار',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'هناك حقيقة مثبتة منذ زمن طويل وهي إن المحتوى المقروء لصفحة',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '2.20',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'د.ك',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Order details list data
  static const List<Map<String, String>> _orderDetails = [
    {'label': 'رقم التعريف بالطلب', 'value': '#8456156'},
    {'label': 'كود التحقق', 'value': '1973'},
    {'label': 'عدد العناصر', 'value': '1'},
  ];

  /// Order details rows
  Widget _buildOrderDetailsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _orderDetails.length,
      itemBuilder: (context, index) {
        final item = _orderDetails[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['label']!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                item['value']!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Bottom action buttons
  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // تتبع الطلب - filled coral button
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.coral,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'تتبع الطلب',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // الغاء الطلب - outlined button
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.coral,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: const BorderSide(
                  color: AppColors.coral,
                  width: 1.5,
                ),
              ),
              child: const Text(
                'الغاء الطلب',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
