import 'package:app/domains/payment_method.dart';
import 'package:app/repository/payment_method_repository.dart';
import 'package:flutter/material.dart';

class PaymentMethodController extends ChangeNotifier {
  final _repository = PaymentMethodRepository();

  Future<int> addPaymentMethod(PaymentMethod paymentMethod) async {
    final result = await _repository.addPaymentMethod(paymentMethod);
    notifyListeners();
    return result;
  }

  Future<int> deletePaymentMethod(PaymentMethod paymentMethod) async {
    final result = await _repository.deletePaymentMethod(paymentMethod);
    notifyListeners();
    return result;
  }

  Future<List<PaymentMethod>> getPaymentMethods() async {
    final result = await _repository.getPaymentMethods();
    notifyListeners();
    return result;
  }
}
