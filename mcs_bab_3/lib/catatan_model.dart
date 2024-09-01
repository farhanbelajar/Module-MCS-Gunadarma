class CatatanModel{
  int? id;
  String? tanggal;
  int? warna;
  String? tugas1;
  String? tugas2;
  String? tugas3;

  CatatanModel({
    this.id,
    required this.tanggal,
    required this.warna,
    required this.tugas1,
    required this.tugas2,
    required this.tugas3,
  });

  //toJson
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tanggal'] = tanggal;
    data['warna'] = warna;
    data['tugas1'] = tugas1;
    data['tugas2'] = tugas2;
    data['tugas3'] = tugas3;
    return data;
  }

  CatatanModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    tanggal = json["tanggal"];
    warna = json["warna"];
    tugas1 = json["tugas1"];
    tugas2 = json["tugas2"];
    tugas3 = json["tugas3"];
  }
}