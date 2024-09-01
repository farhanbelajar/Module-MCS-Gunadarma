import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mcs_bab_3/catatan_controller.dart';
import 'package:get/get.dart';
import 'package:mcs_bab_3/catatan_model.dart';

class AddCatatanScreen extends StatefulWidget {
  const AddCatatanScreen({super.key});

  @override
  State<AddCatatanScreen> createState() => _AddCatatanScreenState();
}

class _AddCatatanScreenState extends State<AddCatatanScreen> {
  final CatatanController catatanController = Get.put(CatatanController());
  String pilihTanggal = "SelectDate";
  int pilihWarna = 1;
  TextEditingController tugas1Controller = TextEditingController();
  TextEditingController tugas2Controller = TextEditingController();
  TextEditingController tugas3Controller = TextEditingController();

  Future<void> selectDate() async{
    DateTime? setDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if(setDate != null && setDate != DateTime.now()){
      setState(() {
        pilihTanggal = DateFormat.yMd().format(setDate).toString();
      });
    }
  }

  addCatatan() async{
    await catatanController.insert(
        catatanModel: CatatanModel(
          tanggal: pilihTanggal,
          warna: pilihWarna,
          tugas1: tugas1Controller.text,
          tugas2: tugas2Controller.text,
          tugas3: tugas3Controller.text,
    ));
    catatanController.getCatatanData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const SizedBox(height: 20,),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            padding: EdgeInsets.all(14),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.1),
                  blurRadius: 10.0,
                )
              ],
              color: const Color(0xff2E3840),
            ),
            child: const Text("add your note", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
          ),

          const SizedBox(height: 30,),

          //pilih tanggal
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(pilihTanggal, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                GestureDetector(
                  child: const Icon(Icons.edit_calendar),
                  onTap: (){selectDate();},
                )
              ],
            ),
          ),

          const SizedBox(height: 20,),

          //pilih warna
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Wrap(
                children: List<Widget>.generate(4, (index){
                  return GestureDetector(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      height: MediaQuery.of(context).size.width/13,
                      width: MediaQuery.of(context).size.width/13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: index == 0? Color(0xff4C4C6D) :
                        index == 1 ? Color(0xff6F61C0) :
                        index == 2 ? Colors.blue[900] :
                        Colors.pink[500]
                      ),
                      child: pilihWarna == index? Icon(Icons.done_all,) : Container()
                    ),
                    onTap: (){
                      setState(() {
                        pilihWarna = index;
                      });
                    },
                  );
                }),
              ),
            ],
          ),

          const SizedBox(height: 20,),

          //isi tugas1
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Tugas 1"),
                TextFormField(
                  controller: tugas1Controller,
                  maxLines: 5,
                  textAlign: TextAlign.justify,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent,),
                      )
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30,),

          //isi tugas2
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Tugas 2"),
                TextFormField(
                  controller: tugas2Controller,
                  maxLines: 5,
                  textAlign: TextAlign.justify,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent,),
                      )
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30,),

          //isi tugas3
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Tugas 3"),
                TextFormField(
                  controller: tugas3Controller,
                  maxLines: 5,
                  textAlign: TextAlign.justify,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purpleAccent,)
                      )
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30,),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async{
                    await addCatatan();
                    Get.back();
                  },
                  icon: Icon(Icons.save_outlined),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}