import 'package:app/domains/payment_method.dart';
import 'package:app/repository/payment_method_repository.dart';
import 'package:flutter/material.dart';

class PaymentMethodController  extends ChangeNotifier {

  final repository = PaymentMethodRepository();


  Future<int> addPaymentMethod(PaymentMethod paymentMethod) async {
    final result = await repository.addPaymentMethod(paymentMethod);
    notifyListeners();
    return result;
  }

  Future<int> deletePaymentMethod(PaymentMethod paymentMethod) async {
    final result = await repository.deletePaymentMethod(paymentMethod);
    notifyListeners();
    return result;
  }

  Future<List<PaymentMethod>> getPaymentMethods() async {
    final result = await repository.getPaymentMethods();
    notifyListeners();
    return result;
  }

}