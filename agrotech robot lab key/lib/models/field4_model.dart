// To parse this JSON data, do
//
//     final field4Model = field4ModelFromJson(jsonString);

import 'dart:convert';

Field4Model field4ModelFromJson(String str) => Field4Model.fromJson(json.decode(str));

String field4ModelToJson(Field4Model data) => json.encode(data.toJson());

class Field4Model {
  DateTime createdAt;
  int entryId;
  String field4;

  Field4Model({
    required this.createdAt,
    required this.entryId,
    required this.field4,
  });

  factory Field4Model.fromJson(Map<String, dynamic> json) => Field4Model(
    createdAt: DateTime.parse(json["created_at"]),
    entryId: json["entry_id"],
    field4: json["field4"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt.toIso8601String(),
    "entry_id": entryId,
    "field4": field4,
  };
}