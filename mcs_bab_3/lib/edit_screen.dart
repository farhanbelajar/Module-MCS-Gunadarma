import 'package:flutter/material.dart';
import 'package:mcs_bab_3/catatan_controller.dart';
import 'package:mcs_bab_3/catatan_model.dart';
import 'package:mcs_bab_3/db.dart';
import 'package:get/get.dart';

class EditScreen extends StatefulWidget {
  CatatanModel catatanModel;

  EditScreen({
    super.key,
    required this.catatanModel,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final CatatanController catatanController = Get.put(CatatanController());
  TextEditingController tugas1Controller = TextEditingController();
  TextEditingController tugas2Controller = TextEditingController();
  TextEditingController tugas3Controller = TextEditingController();

  @override
  void initState() {
    tugas1Controller.text = widget.catatanModel.tugas1 ?? "";
    tugas2Controller.text = widget.catatanModel.tugas2 ?? "";
    tugas3Controller.text = widget.catatanModel.tugas3 ?? "";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children:[
          const SizedBox(height: 22,),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            padding: const EdgeInsets.all(14),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(width: 3, ),
              boxShadow:  const [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.1),
                  blurRadius: 10,
                ),
              ],
              color: const Color(0xff2E3840),
            ),
            child: const Text("Edit your note", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
          ),

          const SizedBox(height: 30,),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Tugas1"),
                TextFormField(
                  controller: tugas1Controller,
                  maxLines: null,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Tugas2"),
                TextFormField(
                  controller: tugas2Controller,
                  maxLines: null,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20,),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Tugas3"),
                TextFormField(
                  controller: tugas3Controller,
                  maxLines: null,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20,),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        // widget.catatanModel.warna == 0?
        // const Color(0xff4C4C6D) : widget.catatanModel.warna == 1?
        // const Color(0xff6F61C0) : widget.catatanModel.warna == 2?
        // Colors.blue[900] : Colors.pink[500],
        onPressed: () async{
          await DB.catatanDb!.rawUpdate(
            """UPDATE ${DB.catatanDbTable} SET tugas1 = '${tugas1Controller.text}' WHERE id = ?""",
            [widget.catatanModel.id],
          );
          await DB.catatanDb!.rawUpdate(
            """UPDATE ${DB.catatanDbTable} SET tugas2 = '${tugas2Controller.text}' WHERE id = ?""",
            [widget.catatanModel.id],
          );
          await DB.catatanDb!.rawUpdate(
            """UPDATE ${DB.catatanDbTable} SET tugas3 = '${tugas3Controller.text}' WHERE id = ?""",
            [widget.catatanModel.id],
          );
          catatanController.getCatatanData();
          Get.back();
        },
        child: const Icon(Icons.save,),
      ),
    );
  }
}