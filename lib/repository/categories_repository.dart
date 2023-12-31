import 'package:app/domains/category.dart';
import 'package:app/repository/categories_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategoriesRepository implements ICategoriesRepository {
  static var db = FirebaseFirestore.instance;
  final String collection = "categories";
  @override
  Future<List<Category>> getCategories() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    return db
        .collection(collection)
        .where("userId", isEqualTo: userId)
        .get()
        .then((value) {
      return value.docs.map((e) => Category.fromMap(e.data())).toList();
    });
  }

  @override
  Future<int> addCategory(Category category) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    var exists = await db
        .collection(collection)
        .where("name", isEqualTo: category.name)
        .where("userId", isEqualTo: userId)
        .get();

    if (exists.docs.isNotEmpty) {
      return Future.value(0);
    }

    var post = category.toMap();

    post.addEntries(
      [
        MapEntry("userId", userId),
      ],
    );

    await db.collection(collection).add(post);
    return Future.value(1);
  }
}
