import 'package:app/domains/payment_method.dart';

abstract class IPaymentMethodRepository {
  Future<List<PaymentMethod>> getPaymentMethods();
  Future<int> addPaymentMethod(PaymentMethod paymentMethod);
  Future<int> deletePaymentMethod(PaymentMethod paymentMethod);
}