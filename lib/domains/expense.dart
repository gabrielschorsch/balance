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

  Expense({
    this.id,
    this.name,
    this.description,
    this.category,
    this.value,
    this.budget,
    this.date,
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category?.toMap(),
      'value': value,
      'budget': budget,
      'date': date?.millisecondsSinceEpoch,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      category: map['category'] != null ? Category.fromMap(map['category']) : null,
      value: map['value']?.toDouble(),
      budget: map['budget']?.toDouble(),
      date: map['date'] != null ? DateTime.fromMillisecondsSinceEpoch(map['date']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Expense(id: $id, name: $name, description: $description, category: $category, value: $value, budget: $budget, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Expense &&
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.category == category &&
      other.value == value &&
      other.budget == budget &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      category.hashCode ^
      value.hashCode ^
      budget.hashCode ^
      date.hashCode;
  }
}
