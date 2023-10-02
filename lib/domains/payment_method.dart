import 'dart:convert';

class PaymentMethod {
  String? id;
  String? name;
  PaymentMethod({
    this.id,
    this.name,
  });
  

  PaymentMethod copyWith({
    String? id,
    String? name,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethod.fromJson(String source) => PaymentMethod.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PaymentMethod(id: $id, name: $name)';

  @override
  bool operator ==(covariant PaymentMethod other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
