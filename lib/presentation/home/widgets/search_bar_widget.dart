import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Custom search bar widget with rounded coral border - Arabic RTL
class SearchBarWidget extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;

  const SearchBarWidget({
    super.key,
    this.hintText = 'تبحث عن وجبة معينه ؟',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColors.coral,
          width: 1.5,
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // Search Icon on the right (RTL)
          Icon(
            Icons.search,
            color: AppColors.coral,
            size: 26,
          ),
          const SizedBox(width: 12),
          // Text Field
          Expanded(
            child: TextField(
              onChanged: onChanged,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              cursorColor: AppColors.coral,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: AppColors.grey.withValues(alpha: 0.7),
                  fontSize: 16,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
