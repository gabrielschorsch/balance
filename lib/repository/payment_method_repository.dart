import 'package:app/domains/payment_method.dart';
import 'package:app/repository/payment_method_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentMethodRepository implements IPaymentMethodRepository {
  static var db = FirebaseFirestore.instance;
  static const collection = "payment_methods";

  @override
  Future<int> addPaymentMethod(PaymentMethod paymentMethod) async {
    var post = paymentMethod.toMap();
    var userId = FirebaseAuth.instance.currentUser!.uid;
    post.addEntries(
      [
        MapEntry("userId", userId),
      ],
    );
    await db.collection(collection).add(post);
    return Future.value(1);
  }

  @override
  Future<int> deletePaymentMethod(PaymentMethod paymentMethod) {
    // list.remove(list.firstWhere((element) => element.id == paymentMethod.id));
    return Future.value(1);
  }

  @override
  Future<List<PaymentMethod>> getPaymentMethods() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    return await db
        .collection(collection)
        .where("userId", isEqualTo: userId)
        .get()
        .then((value) {
      return value.docs.map((e) => PaymentMethod.fromMap(e.data())).toList();
    });
  }
}
