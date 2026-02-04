import 'package:flutter/material.dart';

/// Model class representing a food category
class FoodCategory {
  final String id;
  final String name;
  final String arabicName;
  final String imageAsset;
  final Color backgroundColor; // Custom background color for each category

  const FoodCategory({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.imageAsset,
    required this.backgroundColor,
  });
}
