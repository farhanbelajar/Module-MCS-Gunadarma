// To parse this JSON data, do
//
//     final field1Model = field1ModelFromJson(jsonString);

import 'dart:convert';

Field1Model field1ModelFromJson(String str) => Field1Model.fromJson(json.decode(str));

String field1ModelToJson(Field1Model data) => json.encode(data.toJson());

class Field1Model {
  DateTime createdAt;
  int entryId;
  String field1;

  Field1Model({
    required this.createdAt,
    required this.entryId,
    required this.field1,
  });

  factory Field1Model.fromJson(Map<String, dynamic> json) => Field1Model(
    createdAt: DateTime.parse(json["created_at"]),
    entryId: json["entry_id"],
    field1: json["field1"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt.toIso8601String(),
    "entry_id": entryId,
    "field1": field1,
  };
}