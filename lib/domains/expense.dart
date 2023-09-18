import 'dart:convert';

import 'category.dart';

class Expense {
  String? id;
  String? name;
  Category? category;
  double? value;
  Expense({
    this.id,
    this.name,
    this.category,
    this.value,
  });

  Expense copyWith({
    String? id,
    String? name,
    Category? category,
    double? value,
  }) {
    return Expense(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category?.toMap(),
      'value': value,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      name: map['name'],
      category: map['category'] != null ? Category.fromMap(map['category']) : null,
      value: map['value']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) => Expense.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Expense(id: $id, name: $name, category: $category, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Expense &&
      other.id == id &&
      other.name == name &&
      other.category == category &&
      other.value == value;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      category.hashCode ^
      value.hashCode;
  }
}
