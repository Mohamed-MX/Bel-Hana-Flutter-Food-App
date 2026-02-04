import 'package:flutter/foundation.dart';
import '../../core/constants/app_assets.dart';
import '../../data/models/dish_model.dart';

/// ViewModel for the Trending/Best Sellers Screen
class TrendingViewModel extends ChangeNotifier {
  // Restaurant info
  final String restaurantName = 'اسم المطعم هنا';
  final String restaurantDescription = 'طعام بحري , مشويات , اكلات سريعة';
  final double rating = 5.0;
  final int reviewCount = 100;
  final String deliveryTime = 'متاح التوصيل';

  // Filter tabs
  final List<String> _filterTabs = const ['حلويات', 'مشروبات', 'بيتزا', 'الافضل'];
  int _selectedTabIndex = 3; // "الافضل" selected by default

  // Best sellers (grid items)
  final List<Dish> _bestSellers = const [
    Dish(
      id: 'bs1',
      name: 'Pasta with Sauce',
      arabicName: 'معكرونه بالصوص و قطع بانية خار',
      imageAsset: AppAssets.butterColeslawl,
      price: 2.20,
      category: 'pasta',
      categoryDisplayName: 'معكرونة',
      rating: 4.8,
      reviewCount: 50,
    ),
    Dish(
      id: 'bs2',
      name: 'Pasta with Sauce',
      arabicName: 'معكرونه بالصوص و قطع بانية خار',
      imageAsset: AppAssets.tunaRolls,
      price: 2.20,
      category: 'pasta',
      categoryDisplayName: 'معكرونة',
      rating: 4.8,
      reviewCount: 50,
    ),
    Dish(
      id: 'bs3',
      name: 'Pasta with Sauce',
      arabicName: 'معكرونه بالصوص و قطع بانية خار',
      imageAsset: AppAssets.pizzarrhea,
      price: 2.25,
      category: 'pasta',
      categoryDisplayName: 'معكرونة',
      rating: 4.8,
      reviewCount: 50,
    ),
    Dish(
      id: 'bs4',
      name: 'Pasta with Sauce',
      arabicName: 'معكرونه بالصوص و قطع بانية خار',
      imageAsset: AppAssets.beefMacdont,
      price: 2.20,
      category: 'pasta',
      categoryDisplayName: 'معكرونة',
      rating: 4.8,
      reviewCount: 50,
    ),
  ];

  // Pizza items (list items)
  final List<Dish> _pizzaItems = const [
    Dish(
      id: 'p1',
      name: 'Pasta with Sauce',
      arabicName: 'معكرونه بالصوص و قطع بانية خار',
      description: 'هناك حقيقة مثبتة منذ زمن طويل وهي ان المحتوى المقروء لصفحة ما سيلهي القارى عن التركيز علي',
      imageAsset: AppAssets.pizzarrhea,
      price: 2.20,
      category: 'pizza',
      categoryDisplayName: 'بيتزا',
      rating: 4.8,
      reviewCount: 50,
    ),
    Dish(
      id: 'p2',
      name: 'Pasta with Sauce',
      arabicName: 'معكرونه بالصوص و قطع بانية خار',
      description: 'هناك حقيقة مثبتة منذ زمن طويل وهي ان المحتوى المقروء لصفحة ما سيلهي القارى عن التركيز علي',
      imageAsset: AppAssets.pizzarrhea,
      price: 2.20,
      category: 'pizza',
      categoryDisplayName: 'بيتزا',
      rating: 4.8,
      reviewCount: 50,
    ),
    Dish(
      id: 'p3',
      name: 'Pasta with Sauce',
      arabicName: 'معكرونه بالصوص و قطع بانية خار',
      description: 'هناك حقيقة مثبتة منذ زمن طويل وهي ان المحتوى المقروء لصفحة ما سيلهي القارى عن التركيز علي',
      imageAsset: AppAssets.pizzarrhea,
      price: 2.20,
      category: 'pizza',
      categoryDisplayName: 'بيتزا',
      rating: 4.8,
      reviewCount: 50,
    ),
  ];

  double _cartTotal = 0.0;
  final List<Dish> _cartItems = [];

  // Getters
  List<String> get filterTabs => _filterTabs;
  int get selectedTabIndex => _selectedTabIndex;
  List<Dish> get bestSellers => _bestSellers;
  List<Dish> get pizzaItems => _pizzaItems;
  double get cartTotal => _cartTotal;
  List<Dish> get cartItems => _cartItems;

  // Actions
  void selectTab(int index) {
    if (_selectedTabIndex != index) {
      _selectedTabIndex = index;
      notifyListeners();
    }
  }

  void addToCart(Dish dish) {
    _cartItems.add(dish);
    _cartTotal += dish.price;
    notifyListeners();
  }
}
