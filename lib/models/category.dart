import 'package:flutter/material.dart';

enum Category {
  food('food'),
  travel('travel'),
  leisure('leisure'),
  work('work');

  const Category(this.value);

  factory Category.fromValue(String value) {
    return values.firstWhere((e) => e.value == value);
  }

  final String value;
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};
