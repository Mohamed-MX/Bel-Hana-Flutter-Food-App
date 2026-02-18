import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import '../../data/models/dish_model.dart';
import '../../data/models/category_model.dart';

/// ViewModel for the Home Screen using ChangeNotifier pattern
class HomeViewModel extends ChangeNotifier {
  // User info
  final String userName = 'Mark Miller';
  final String deliveryAddress = '19 الشيخ احمد الصاوي، مدينة نصر';
  final String locationTitle = 'الموقع الحالي';

  // Categories with Arabic names, images, and CUSTOM COLORS
  // ⬇️ CHANGE THESE COLORS TO CUSTOMIZE EACH CATEGORY ⬇️
  final List<FoodCategory> _categories = const [
    FoodCategory(
      id: 'fastfood',
      name: 'Fast Food',
      arabicName: 'وجبات سريعة',
      imageAsset: AppAssets.fastFood,
      backgroundColor: Color(0xFFF55540), // red
    ),
    FoodCategory(
      id: 'grilled',
      name: 'Grilled',
      arabicName: 'مشويات',
      imageAsset: AppAssets.grilled,
      backgroundColor: Color(0xFFFFA5A5), // pink
    ),
    FoodCategory(
      id: 'seafood',
      name: 'Seafood',
      arabicName: 'مأكولات بحرية',
      imageAsset: AppAssets.seafood,
      backgroundColor: Color(0xFFB7FF9A), // mint green'
    ),
    FoodCategory(
      id: 'meats',
      name: 'Meats',
      arabicName: 'لحوم',
      imageAsset: AppAssets.meats,
      backgroundColor: Color(0xFF96FFFB), // cyan
    ),
  ];

  // Dishes with Arabic names, ratings, and reviews
  final List<Dish> _allDishes = const [
    Dish(
      id: '1',
      name: "Spicy Burger",
      arabicName: "بج بيرجر سبايسي",
      imageAsset: AppAssets.spicyBurger,
      price: 150,
      category: 'fastfood',
      categoryDisplayName: 'وجبات سريعة',
      rating: 5.0,
      reviewCount: 100,
    ),
    Dish(
      id: '2',
      name: 'Spicy Burger',
      arabicName: 'بج بيرجر سبايسي',
      imageAsset: AppAssets.spicyBurger,
      price: 150,
      category: 'fastfood',
      categoryDisplayName: 'وجبات سريعة',
      rating: 5.0,
      reviewCount: 100,
    ),
    Dish(
      id: '3',
      name: 'Tuna Rolls',
      arabicName: 'رولات التونة',
      imageAsset: AppAssets.tunaRolls,
      price: 180,
      category: 'seafood',
      categoryDisplayName: 'مأكولات بحرية',
      rating: 4.8,
      reviewCount: 85,
    ),
    Dish(
      id: '4',
      name: 'Grilled Chicken',
      arabicName: 'دجاج مشوي',
      imageAsset: AppAssets.grilled,
      price: 200,
      category: 'grilled',
      categoryDisplayName: 'مشويات',
      rating: 4.9,
      reviewCount: 120,
    ),
    Dish(
      id: '5',
      name: 'Shrimp Platter',
      arabicName: 'طبق الجمبري',
      imageAsset: AppAssets.shrimpDish,
      price: 280,
      category: 'seafood',
      categoryDisplayName: 'مأكولات بحرية',
      rating: 4.7,
      reviewCount: 95,
    ),
  ];

  int _selectedCategoryIndex = -1; // -1 means no category selected (show all)
  int _cartCount = 0;

  // Getters
  List<FoodCategory> get categories => _categories;
  
  int get selectedCategoryIndex => _selectedCategoryIndex;
  
  int get cartCount => _cartCount;

  List<Dish> get dishes {
    if (_selectedCategoryIndex == -1) {
      return _allDishes;
    }
    final selectedCategory = _categories[_selectedCategoryIndex];
    return _allDishes
        .where((dish) => dish.category == selectedCategory.id)
        .toList();
  }

  // Actions
  void selectCategory(int index) {
    if (_selectedCategoryIndex == index) {
      _selectedCategoryIndex = -1; // Deselect if tapping same category
    } else {
      _selectedCategoryIndex = index;
    }
    notifyListeners();
  }

  void addToCart(Dish dish) {
    _cartCount++;
    notifyListeners();
  }
}
