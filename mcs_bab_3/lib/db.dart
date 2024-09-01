import 'package:mcs_bab_3/catatan_model.dart';
import 'package:sqflite/sqflite.dart';

class DB{
  static Database? catatanDb;
  static const String catatanDbTable = "catatan";

  static Future<void> initCatatanDb() async{
    if(catatanDb != null){
      return;
    }
    try{
      String path = "${await getDatabasesPath()}/catatan.db";
      catatanDb = await openDatabase(
        path, version: 1, onCreate: (db, version){
          const sql = """CREATE TABLE $catatanDbTable(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          tanggal STRING,
          warna INTEGER, 
          tugas1 STRING, 
          tugas2 STRING, 
          tugas3 STRING)""";
          return db.execute(sql);
      },
      );
    } catch(e){
      print("error : $e");
    }
  }

  //insert
  static Future<int> insert(CatatanModel catatanModel) async{
    return await catatanDb?.insert(catatanDbTable, catatanModel.toJson()) ?? 1;
  }

  //retrieve
  static Future<List<Map<String, dynamic>>> query() async{
    return await catatanDb!.query(catatanDbTable,);
  }

  //delete
  static delete(CatatanModel catatanModel)async {
    return catatanDb!.delete(catatanDbTable, where: "id = ?", whereArgs: [catatanModel.id]);
  }

  //update warna 0
  // static updateWarna0(CatatanModel catatanModel) async{
  //   return catatanDb!.update(DB.catatanDbTable, where: "id = ?", whereArgs: [catatanModel.id]);
  // }
  
  //update warna jadi 0
  static updateWarna0(int id) async{
    return await catatanDb!.rawUpdate(
      """UPDATE $catatanDbTable SET warna = 0 WHERE id = ?""", [id]
    );
  }

  //update warna jadi 1
  static updateWarna1(int id) async{
    return await catatanDb!.rawUpdate(
        """UPDATE $catatanDbTable SET warna = 1 WHERE id = ?""", [id]
    );
  }

  //update warna jadi 2
  static updateWarna2(int id) async{
    return await catatanDb!.rawUpdate(
        """UPDATE $catatanDbTable SET warna = 2 WHERE id = ?""", [id]
    );
  }

  //update warna jadi 3
  static updateWarna3(int id) async{
    return await catatanDb!.rawUpdate(
        """UPDATE $catatanDbTable SET warna = 3 WHERE id = ?""", [id]
    );
  }

  // static emptyTugas1(int id) async{
  //   return await catatanDb!.rawUpdate(
  //       """UPDATE $catatanDbTable SET tugas1 = '' WHERE id = ?""", [id]
  //   );
  // }
  //
  // static emptyTugas2(int id) async{
  //   return await catatanDb!.rawUpdate(
  //       """UPDATE $catatanDbTable SET tugas2 = '' WHERE id = ?""", [id]
  //   );
  // }
  //
  // static emptyTugas3(int id) async{
  //   return await catatanDb!.rawUpdate(
  //       """UPDATE $catatanDbTable SET tugas3 = '' WHERE id = ?""", [id]
  //   );
  // }
}