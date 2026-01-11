import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final String description;
  final IconData icon;
  final List<IconData> secondaryIcons;
  final List<Color> gradient;
  final String image;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.secondaryIcons,
    required this.gradient,
    required this.image,
  });
}