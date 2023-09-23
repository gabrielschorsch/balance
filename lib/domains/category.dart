import 'dart:convert';

class Category {
  String? id;
  String? name;
  String? color;
  double? budget;
  Category({this.id, this.name, this.color, this.budget});

  Category copyWith({
    String? id,
    String? name,
    String? color,
    double? budget,
  }) {
    return Category(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        budget: budget ?? this.budget);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'color': color, 'budget': budget};
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        id: map['id'],
        name: map['name'],
        color: map['color'],
        budget: map['budget']);
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Category(id: $id, name: $name, color: $color, budget: $budget)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.id == id &&
        other.name == name &&
        other.color == color &&
        other.budget == budget;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ color.hashCode ^ budget.hashCode;
  }
}
