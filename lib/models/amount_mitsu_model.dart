import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AmountMitsuModel {
  final String id;
  final String code;
  final String name;
  final String qty;
  final String userId;
  final String lat;
  final String lng;
  final String status;

  AmountMitsuModel({
    required this.id,
    required this.code,
    required this.name,
    required this.qty,
    required this.userId,
    required this.lat,
    required this.lng,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'name': name,
      'qty': qty,
      'userId': userId,
      'lat': lat,
      'lng': lng,
      'status': status,
    };
  }

  factory AmountMitsuModel.fromMap(Map<String, dynamic> map) {
    return AmountMitsuModel(
      id: (map['id'] ?? '') as String,
      code: (map['code'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      qty: (map['qty'] ?? '') as String,
      userId: (map['userId'] ?? '') as String,
      lat: (map['lat'] ?? '') as String,
      lng: (map['lng'] ?? '') as String,
      status: (map['status'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AmountMitsuModel.fromJson(String source) => AmountMitsuModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
