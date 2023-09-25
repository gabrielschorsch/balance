import 'package:app/domains/category.dart';
import 'package:app/repository/categories_interface.dart';
class CategoriesRepository implements ICategoriesRepository {
  @override
  Future<List<Category>> getCategories() {
    List<Category> mockupCategories = [
      Category(
        id: "1",
        color: "#FF0000",
        name: "Alimentação",
      ),
      Category(
        id: "2",
        color: "#00FF00",
        name: "Transporte",
      ),
      Category(
        id: "3",
        color: "#0000FF",
        name: "Lazer",
      ),
    ];
    //mocking categories =
    return Future.value(mockupCategories);
  }
}
