// To parse this JSON data, do
//
//     final field3Model = field3ModelFromJson(jsonString);

import 'dart:convert';

Field3Model field3ModelFromJson(String str) => Field3Model.fromJson(json.decode(str));

String field3ModelToJson(Field3Model data) => json.encode(data.toJson());

class Field3Model {
  DateTime createdAt;
  int entryId;
  String field3;

  Field3Model({
    required this.createdAt,
    required this.entryId,
    required this.field3,
  });

  factory Field3Model.fromJson(Map<String, dynamic> json) => Field3Model(
    createdAt: DateTime.parse(json["created_at"]),
    entryId: json["entry_id"],
    field3: json["field3"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt.toIso8601String(),
    "entry_id": entryId,
    "field3": field3,
  };
}