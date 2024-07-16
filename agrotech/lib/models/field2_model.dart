// To parse this JSON data, do
//
//     final field2Model = field2ModelFromJson(jsonString);

import 'dart:convert';

Field2Model field2ModelFromJson(String str) => Field2Model.fromJson(json.decode(str));

String field2ModelToJson(Field2Model data) => json.encode(data.toJson());

class Field2Model {
  DateTime createdAt;
  int entryId;
  String field2;

  Field2Model({
    required this.createdAt,
    required this.entryId,
    required this.field2,
  });

  factory Field2Model.fromJson(Map<String, dynamic> json) => Field2Model(
    createdAt: DateTime.parse(json["created_at"]),
    entryId: json["entry_id"],
    field2: json["field2"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt.toIso8601String(),
    "entry_id": entryId,
    "field2": field2,
  };
}