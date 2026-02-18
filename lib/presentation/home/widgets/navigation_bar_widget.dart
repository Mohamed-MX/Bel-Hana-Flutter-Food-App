import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../home_screen.dart';
import '../../favorites/favorites_screen.dart';
import '../../orders/orders_screen.dart';
import '../../profile/profile_screen.dart';
import '../../track_order/track_order_screen.dart';

/// Main navigation bar widget with bottom app bar and center cart FAB.
/// Acts as the root screen that hosts all main pages via IndexedStack.
class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int _currentIndex = 0;

  // Pages order: Home, Favorites, (cart FAB gap), Orders, Profile
  final List<Widget> _pages = const [
    HomeScreen(),
    FavoritesScreen(),
    SizedBox.shrink(), // Placeholder for center FAB
    OrdersScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    if (index == 2) return; // Center is cart FAB, handled separately
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      extendBody: true,
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: _buildCartFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  /// Cart FAB - navigates to Track Order page
  Widget _buildCartFAB() {
    return Container(
      width: 62,
      height: 62,
      margin: const EdgeInsets.only(top: 24),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TrackOrderScreen()),
          );
        },
        backgroundColor: AppColors.coral,
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  /// Custom Bottom Navigation Bar matching the design
  Widget _buildBottomNavBar() {
    return BottomAppBar(
      color: Colors.white,
      elevation: 12,
      shadowColor: Colors.black26,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 65,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Home (RTL rightmost = first in RTL row)
              _buildNavItem(
                index: 0,
                icon: Icons.home_rounded,
                isHome: true,
              ),

              // Favorites
              _buildNavItem(
                index: 1,
                icon: Icons.favorite_border,
              ),

              // Center spacer for FAB
              const SizedBox(width: 48),

              // Orders
              _buildNavItem(
                index: 3,
                icon: Icons.shopping_bag_outlined,
              ),

              // Profile
              _buildNavItem(
                index: 4,
                icon: Icons.person_outline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Individual nav bar item
  Widget _buildNavItem({
    required int index,
    required IconData icon,
    bool isHome = false,
  }) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? AppColors.coral : const Color(0xFF2D2D2D);

    return InkWell(
      onTap: () => _onTabTapped(index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: isHome
            ? _buildHomeIcon(isSelected)
            : Icon(
                icon,
                color: color,
                size: 28,
              ),
      ),
    );
  }

  /// Custom home icon (pentagon shape matching design)
  Widget _buildHomeIcon(bool isSelected) {
    final color = isSelected ? AppColors.coral : const Color(0xFF2D2D2D);
    return SizedBox(
      width: 28,
      height: 28,
      child: CustomPaint(
        painter: _HomePentagonPainter(color: color, filled: isSelected),
        child: Center(
          child: Container(
            width: 4,
            height: 10,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom painter for the pentagon-shaped home icon
class _HomePentagonPainter extends CustomPainter {
  final Color color;
  final bool filled;

  _HomePentagonPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Pentagon home shape (rounded house)
    path.moveTo(w * 0.5, h * 0.02);   // Top center point
    path.quadraticBezierTo(w * 0.58, h * 0.02, w * 0.88, h * 0.25);
    path.quadraticBezierTo(w * 1.02, h * 0.36, w * 0.98, h * 0.55);
    path.lineTo(w * 0.95, h * 0.78);
    path.quadraticBezierTo(w * 0.93, h * 0.98, w * 0.78, h * 0.98);
    path.lineTo(w * 0.22, h * 0.98);
    path.quadraticBezierTo(w * 0.07, h * 0.98, w * 0.05, h * 0.78);
    path.lineTo(w * 0.02, h * 0.55);
    path.quadraticBezierTo(w * -0.02, h * 0.36, w * 0.12, h * 0.25);
    path.quadraticBezierTo(w * 0.42, h * 0.02, w * 0.5, h * 0.02);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _HomePentagonPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.filled != filled;
  }
}
