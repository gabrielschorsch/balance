import 'package:app/domains/category.dart';
import 'package:app/repository/categories_repository.dart';
import 'package:flutter/material.dart';

class CategoryController extends ChangeNotifier {
  final repository = CategoriesRepository();

  Future<List<Category>> getCategories() async {
    return await repository.getCategories();
  }
}
