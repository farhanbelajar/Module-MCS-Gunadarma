import 'dart:io' as io;

class Model{
  io.File? image;
  int? npm;
  String? name;
  String? desc;

  Model({
    required this.image,
    required this.npm,
    required this.name,
    required this.desc,
  });
}