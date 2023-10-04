// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/domains/payment_method.dart';

import 'category.dart';

class Expense {
  String? id;
  String? name;
  String? description;
  Category? category;
  double? value;
  double? budget;
  DateTime? date;
  PaymentMethod? paymentMethod;

  Expense({
    this.id,
    this.name,
    this.description,
    this.category,
    this.value,
    this.budget,
    this.date,
    this.paymentMethod,
  });

  Expense copyWith({
    String? id,
    String? name,
    String? description,
    Category? category,
    double? value,
    double? budget,
    DateTime? date,
    PaymentMethod? paymentMethod,
  }) {
    return Expense(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      value: value ?? this.value,
      budget: budget ?? this.budget,
      date: date ?? this.date,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'category': category?.toMap(),
      'value': value,
      'budget': budget,
      'date': date?.millisecondsSinceEpoch,
      'paymentMethod': paymentMethod?.toMap(),
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      category: map['category'] != null ? Category.fromMap(map['category'] as Map<String,dynamic>) : null,
      value: map['value'] != null ? map['value'] as double : null,
      budget: map['budget'] != null ? map['budget'] as double : null,
      date: map['date'] != null ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int) : null,
      paymentMethod: map['paymentMethod'] != null ? PaymentMethod.fromMap(map['paymentMethod'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) => Expense.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expense(id: $id, name: $name, description: $description, category: $category, value: $value, budget: $budget, date: $date, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(covariant Expense other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.category == category &&
      other.value == value &&
      other.budget == budget &&
      other.date == date &&
      other.paymentMethod == paymentMethod;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      category.hashCode ^
      value.hashCode ^
      budget.hashCode ^
      date.hashCode ^
      paymentMethod.hashCode;
  }
}
