import 'dart:convert';

import 'category.dart';

class Expense {
  String? id;
  String? name;
  Category? category;
  double? value;
  double? budget;
  DateTime? date;
  
  Expense({
    this.id,
    this.name,
    this.category,
    this.value,
    this.budget,
    this.date,
  });


  Expense copyWith({
    String? id,
    String? name,
    Category? category,
    double? value,
    double? budget,
    DateTime? date,
  }) {
    return Expense(
      id: id ?? this.id,
      name: name ?? this.name,
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
      category: map['category'] != null ? Category.fromMap(map['category']) : null,
      value: map['value']?.toDouble(),
      budget: map['budget']?.toDouble(),
      date: map['date'] != null ? DateTime.fromMillisecondsSinceEpoch(map['date']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) => Expense.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Expense(id: $id, name: $name, category: $category, value: $value, budget: $budget, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Expense &&
      other.id == id &&
      other.name == name &&
      other.category == category &&
      other.value == value &&
      other.budget == budget &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      category.hashCode ^
      value.hashCode ^
      budget.hashCode ^
      date.hashCode;
  }
}
