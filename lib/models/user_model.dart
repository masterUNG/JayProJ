import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class UserModel {
  final String mem_id;
  final String mem_name;
  final String mem_address;
  final String mem_tel;
  final String mem_username;
  final String mem_password;
  final String mem_email;
  final String mem_img;
  final String mem_type;
  final String mem_code;
  final String datesave;
  final String answer;
  UserModel({
    required this.mem_id,
    required this.mem_name,
    required this.mem_address,
    required this.mem_tel,
    required this.mem_username,
    required this.mem_password,
    required this.mem_email,
    required this.mem_img,
    required this.mem_type,
    required this.mem_code,
    required this.datesave,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mem_id': mem_id,
      'mem_name': mem_name,
      'mem_address': mem_address,
      'mem_tel': mem_tel,
      'mem_username': mem_username,
      'mem_password': mem_password,
      'mem_email': mem_email,
      'mem_img': mem_img,
      'mem_type': mem_type,
      'mem_code': mem_code,
      'datesave': datesave,
      'answer': answer,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      mem_id: (map['mem_id'] ?? '') as String,
      mem_name: (map['mem_name'] ?? '') as String,
      mem_address: (map['mem_address'] ?? '') as String,
      mem_tel: (map['mem_tel'] ?? '') as String,
      mem_username: (map['mem_username'] ?? '') as String,
      mem_password: (map['mem_password'] ?? '') as String,
      mem_email: (map['mem_email'] ?? '') as String,
      mem_img: (map['mem_img'] ?? '') as String,
      mem_type: (map['mem_type'] ?? '') as String,
      mem_code: (map['mem_code'] ?? '') as String,
      datesave: (map['datesave'] ?? '') as String,
      answer: (map['answer'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
