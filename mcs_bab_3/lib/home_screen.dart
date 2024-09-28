import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mcs_bab_3/add_catatan_screen.dart';
import 'package:mcs_bab_3/catatan_controller.dart';
import 'package:mcs_bab_3/catatan_model.dart';
import 'package:mcs_bab_3/db.dart';
import 'package:mcs_bab_3/edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CatatanController catatanController = Get.put(CatatanController());

  Future<void> ubahTanggal(BuildContext context, CatatanModel catatanModel) async{
    DateTime? setDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );

    if(setDate != null && setDate != DateTime.now()){
      setState(() {
        DB.catatanDb!.rawUpdate(
          """UPDATE ${DB.catatanDbTable} SET tanggal = "${DateFormat.yMd().format(setDate)}" WHERE id = ?""",
          [catatanModel.id],
        );
        catatanController.getCatatanData();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    catatanController.getCatatanData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catatan App"),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: (){
              Get.to(const AddCatatanScreen());
            },
          ),
          const SizedBox(width: 10,),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(14),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.1),
                    blurRadius: 10.0,
                  ),
                ],
                color: const Color(0xff2E3840),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create your notes in this App',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '- Write your plan',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '- Write your needs',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '- Write your memories',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30,),

            Container(
              width: double.infinity,
              child: Obx(() => ListView.builder(
                itemCount: catatanController.catatanList.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  CatatanModel catatanModel = catatanController.catatanList[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 18,),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: catatanModel.warna == 0?
                      const Color(0xff4C4C6D) : catatanModel.warna == 1?
                      const Color(0xff6F61C0) : catatanModel.warna == 2?
                      Colors.blue[900] : Colors.pink[500],
                      border: Border.all(width: 3, color: Colors.white,)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("${catatanModel.tanggal}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      ubahTanggal(context, catatanController.catatanList[index]);
                                    });
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.brush),
                                  onPressed: (){
                                    setState(() {
                                      if(catatanModel.warna == 0){
                                        catatanController.updateWarna1(id: catatanModel.id!);
                                      } else if(catatanModel.warna == 1){
                                        catatanController.updateWarna2(id: catatanModel.id!);
                                      } else if(catatanModel.warna == 2){
                                        catatanController.updateWarna3(id: catatanModel.id!);
                                      } else{
                                        catatanController.updateWarna0(id: catatanModel.id!);
                                      }
                                      catatanController.getCatatanData();
                                    });
                                  },
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      catatanController.delete(catatanModel: catatanModel);
                                      catatanController.getCatatanData();
                                    });
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      Get.to(EditScreen(catatanModel: catatanModel));
                                    });
                                  },
                                  icon: const Icon(Icons.edit),)
                              ],
                            )
                          ],
                        ),

                        const SizedBox(height: 10,),

                        Container(height: 3, color: Colors.white,),

                        const SizedBox(height: 10,),

                        const Text("Tugas1", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),

                        Text(catatanModel.tugas1!),

                        const SizedBox(height: 10,),

                        const Text("Tugas2", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),

                        Text(catatanModel.tugas2!),

                        const SizedBox(height: 10,),

                        const Text("Tugas3", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),

                        Text(catatanModel.tugas3!),
                      ],
                    ),
                  );
                },

              ),),
            )
          ],
        ),
      ),
    );
  }
}