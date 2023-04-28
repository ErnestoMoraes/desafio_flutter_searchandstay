import 'dart:convert';

class RuleModel {
  final int id;
  final String name;
  final int active;
  final int order;

  RuleModel({
    required this.id,
    required this.name,
    required this.active,
    required this.order,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'active': active,
      'order': order,
    };
  }

  factory RuleModel.fromMap(Map<String, dynamic> map) {
    return RuleModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      active: map['active'] ?? 0,
      order: map['order'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RuleModel.fromJson(String source) =>
      RuleModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

// {
//     "id": 502,
//     "name": "rule 5",
//     "active": 0,
//     "order": 0
// },