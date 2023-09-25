import 'package:app/domains/category.dart';

abstract class ICategoriesRepository {
  Future<List<Category>> getCategories();
  
}