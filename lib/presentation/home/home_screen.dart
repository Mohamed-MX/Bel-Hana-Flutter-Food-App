import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_assets.dart';
import 'home_viewmodel.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/offer_banner_widget.dart';
import 'widgets/category_chips_widget.dart';
import 'widgets/dish_card_widget.dart';

/// Home Screen for the Arabic Food Delivery App
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Gradient background from light pink to white
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFDD2D2), // Very light pink at top
              Colors.white,      // White at bottom
            ],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Sticky Header
              _buildHeader(context),

              // Sticky Search Bar
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: SearchBarWidget(),
              ),

              const SizedBox(height: 12),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Main Content
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            // Categories Section
                            Consumer<HomeViewModel>(
                              builder: (context, viewModel, child) {
                                return CategoryChipsWidget(
                                  categories: viewModel.categories,
                                  selectedIndex: viewModel.selectedCategoryIndex,
                                  onSelected: viewModel.selectCategory,
                                );
                              },
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Special Offer Banner
                            const OfferBannerWidget(),
                            
                            const SizedBox(height: 20),
                            
                            // Best of Today Section Header
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '🔥',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'الافضل خلال اليوم',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 12),
                            
                            // Dishes Horizontal List
                            Consumer<HomeViewModel>(
                              builder: (context, viewModel, child) {
                                final dishes = viewModel.dishes;
                                return SizedBox(
                                  height: 290,
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        left: 8,
                                        right: 8,
                                        bottom: 10,
                                      ),
                                      itemCount: dishes.length,
                                      separatorBuilder: (context, index) => 
                                          const SizedBox(width: 14),
                                      itemBuilder: (context, index) {
                                        return DishCardWidget(
                                          dish: dishes[index],
                                          onTap: () {},
                                          onAddToCart: () {
                                            viewModel.addToCart(dishes[index]);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            
                            const SizedBox(height: 20),

                            // All Restaurants Section Header
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'جميع المطاعم',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '2 مطعم',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.coral,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'بالقرب منك',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            // Extra bottom padding to avoid nav bar overlap
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the light header section with location and profile
  /// Profile on LEFT (RTL start), Bell on RIGHT (RTL end)
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                // Profile Avatar on RIGHT side (RTL start) → navigates to Track Order
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/track-order'),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.greyLight,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        AppAssets.profileAvatar,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.greyLight,
                            child: const Icon(
                              Icons.person,
                              color: AppColors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Location Info (center)
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(الاف
                            viewModel.locationTitle,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.location_on,
                            color: AppColors.coral,
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        viewModel.deliveryAddress,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Notification Bell on LEFT side (RTL end) - tap to go to Trending
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/trending'),
                  child: const Icon(
                    Icons.notifications_none_outlined,
                    color: AppColors.textSecondary,
                    size: 26,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
