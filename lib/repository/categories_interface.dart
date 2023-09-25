import 'package:app/domains/category.dart';

abstract class ICategoriesRepository {
  Future<List<Category>> getCategories();
  Future<int> addCategory(Category category);
}
