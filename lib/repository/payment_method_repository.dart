import 'package:app/domains/payment_method.dart';
import 'package:app/repository/payment_method_interface.dart';

class PaymentMethodRepository implements IPaymentMethodRepository {
  static List<PaymentMethod> list = [];

  @override
  Future<int> addPaymentMethod(PaymentMethod paymentMethod) {
    list.add(paymentMethod);
    return Future.value(1);
  }

  @override
  Future<int> deletePaymentMethod(PaymentMethod paymentMethod) {
    list.remove(list.firstWhere((element) => element.id == paymentMethod.id));
    return Future.value(1);
  }

  @override
  Future<List<PaymentMethod>> getPaymentMethods() {
    return Future.value(list);
  }
}
