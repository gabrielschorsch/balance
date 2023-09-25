import 'package:app/domains/category.dart';
import 'package:app/repository/categories_interface.dart';

class CategoriesRepository implements ICategoriesRepository {
  static List<Category> mockup = [
    Category(
      id: "1",
      //pastel magenta
      color: "#FFB6C1",
      name: "Alimentação",
    ),
    Category(
      id: "2",
      //pastel green
      color: "#98FB98",
      name: "Transporte",
    ),
    Category(
      id: "3",
      //pastel blue
      color: "#ADD8E6",
      name: "Lazer",
    ),
  ];

  @override
  Future<List<Category>> getCategories() {
    //mocking categories =
    return Future.value(mockup);
  }

  @override
  Future<int> addCategory(Category category) {
    mockup.add(category);
    return Future.value(1);
  }
}
