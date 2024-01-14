// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DataModel {

  final String invid;
  final String number;
  final String invdate;
  final String invcode;
  final String invname;
  final String invdue;
  final String invnet;
  final String invvat;
  final String invsumtt;
  final String invtype;
  final String clame;
  final String edno;
  final String tsno;
  final String invpo;
  final String evcode;
  final String evname;
  final String usrLine;
  final String invbarcode;
  final String scandate;
  final String WEBSCAN;
  final String WEBSCANDATE;
  final String WEBSCANBY;
  final String startdate;
  final String memId;
  final String imgBill;
  final String invImg;
  final String taxnum;
  final String invStatus;
  final String latt1;
  final String long1;
  final String invNon;
  DataModel({
    required this.invid,
    required this.number,
    required this.invdate,
    required this.invcode,
    required this.invname,
    required this.invdue,
    required this.invnet,
    required this.invvat,
    required this.invsumtt,
    required this.invtype,
    required this.clame,
    required this.edno,
    required this.tsno,
    required this.invpo,
    required this.evcode,
    required this.evname,
    required this.usrLine,
    required this.invbarcode,
    required this.scandate,
    required this.WEBSCAN,
    required this.WEBSCANDATE,
    required this.WEBSCANBY,
    required this.startdate,
    required this.memId,
    required this.imgBill,
    required this.invImg,
    required this.taxnum,
    required this.invStatus,
    required this.latt1,
    required this.long1,
    required this.invNon,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'invid': invid,
      'number': number,
      'invdate': invdate,
      'invcode': invcode,
      'invname': invname,
      'invdue': invdue,
      'invnet': invnet,
      'invvat': invvat,
      'invsumtt': invsumtt,
      'invtype': invtype,
      'clame': clame,
      'edno': edno,
      'tsno': tsno,
      'invpo': invpo,
      'evcode': evcode,
      'evname': evname,
      'usrLine': usrLine,
      'invbarcode': invbarcode,
      'scandate': scandate,
      'WEBSCAN': WEBSCAN,
      'WEBSCANDATE': WEBSCANDATE,
      'WEBSCANBY': WEBSCANBY,
      'startdate': startdate,
      'memId': memId,
      'imgBill': imgBill,
      'invImg': invImg,
      'taxnum': taxnum,
      'invStatus': invStatus,
      'latt1': latt1,
      'long1': long1,
      'invNon': invNon,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      invid: (map['invid'] ?? '') as String,
      number: (map['number'] ?? '') as String,
      invdate: (map['invdate'] ?? '') as String,
      invcode: (map['invcode'] ?? '') as String,
      invname: (map['invname'] ?? '') as String,
      invdue: (map['invdue'] ?? '') as String,
      invnet: (map['invnet'] ?? '') as String,
      invvat: (map['invvat'] ?? '') as String,
      invsumtt: (map['invsumtt'] ?? '') as String,
      invtype: (map['invtype'] ?? '') as String,
      clame: (map['clame'] ?? '') as String,
      edno: (map['edno'] ?? '') as String,
      tsno: (map['tsno'] ?? '') as String,
      invpo: (map['invpo'] ?? '') as String,
      evcode: (map['evcode'] ?? '') as String,
      evname: (map['evname'] ?? '') as String,
      usrLine: (map['usrLine'] ?? '') as String,
      invbarcode: (map['invbarcode'] ?? '') as String,
      scandate: (map['scandate'] ?? '') as String,
      WEBSCAN: (map['WEBSCAN'] ?? '') as String,
      WEBSCANDATE: (map['WEBSCANDATE'] ?? '') as String,
      WEBSCANBY: (map['WEBSCANBY'] ?? '') as String,
      startdate: (map['startdate'] ?? '') as String,
      memId: (map['memId'] ?? '') as String,
      imgBill: (map['imgBill'] ?? '') as String,
      invImg: (map['invImg'] ?? '') as String,
      taxnum: (map['taxnum'] ?? '') as String,
      invStatus: (map['invStatus'] ?? '') as String,
      latt1: (map['latt1'] ?? '') as String,
      long1: (map['long1'] ?? '') as String,
      invNon: (map['invNon'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataModel.fromJson(String source) => DataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
