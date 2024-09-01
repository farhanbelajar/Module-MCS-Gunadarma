import 'package:get/get.dart';
import 'package:mcs_bab_3/catatan_model.dart';

import 'db.dart';

class CatatanController extends GetxController{
  var catatanList = [].obs;

  //get all data from the table
  void getCatatanData() async{
    List<Map<String, dynamic>> catatanData = await DB.query();
    catatanList.assignAll(catatanData.map((e) => CatatanModel.fromJson(e)).toList());
  }

  //insert atau tambah data
  Future<int> insert({required CatatanModel catatanModel}) async{
    return await DB.insert(catatanModel);
  }

  //delete
  void delete({required CatatanModel catatanModel}) async{
    await DB.delete(catatanModel);
  }

  //update warna jadi 0
  void updateWarna0({required int id}) async{
    await DB.updateWarna0(id);
  }

  //update warna jadi 1
  void updateWarna1({required int id}) async{
    await DB.updateWarna1(id);
  }

  //update warna jadi 2
  void updateWarna2({required int id}) async{
    await DB.updateWarna2(id);
  }

  //update warna jadi 3
  void updateWarna3({required int id}) async{
    await DB.updateWarna3(id);
  }
  //
  // //empty Tugas 1
  // void emptyTugas1({required int id}) async{
  //   await DB.emptyTugas1(id);
  // }
  //
  // //empty Tugas 2
  // void emptyTugas2({required int id}) async{
  //   await DB.emptyTugas2(id);
  // }
  //
  // //empty Tugas 3
  // void emptyTugas3({required int id}) async{
  //   await DB.emptyTugas3(id);
  // }
}