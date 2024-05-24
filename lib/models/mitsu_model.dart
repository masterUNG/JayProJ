import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MitsuModel {
  final String code;
  final String name;
  final String uom;
  final String type;
  final String gprice;
  final String onhand;
  final String named;
  MitsuModel({
    required this.code,
    required this.name,
    required this.uom,
    required this.type,
    required this.gprice,
    required this.onhand,
    required this.named,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'name': name,
      'uom': uom,
      'type': type,
      'gprice': gprice,
      'onhand': onhand,
      'named': named,
    };
  }

  factory MitsuModel.fromMap(Map<String, dynamic> map) {
    return MitsuModel(
      code: (map['code'].trim() ?? '') as String,
      name: (map['name'].trim() ?? '') as String,
      uom: (map['uom'].trim() ?? '') as String,
      type: (map['type'].trim() ?? '') as String,
      gprice: (map['gprice'].trim() ?? '') as String,
      onhand: (map['onhand'].trim() ?? '') as String,
      named: (map['named'].trim() ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MitsuModel.fromJson(String source) => MitsuModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
