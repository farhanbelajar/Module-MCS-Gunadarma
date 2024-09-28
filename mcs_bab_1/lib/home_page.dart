import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcs_bab_1/receiver.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int start = 0;
  TextEditingController input1Controller = TextEditingController();
  TextEditingController input2Controller = TextEditingController();
  TextEditingController messageController = TextEditingController();
  int result = 0;
  String flutterUrl = "https://flutter.dev";

  void increment(){
    setState(() {
      start++;
    });
  }

  void decrement(){
    setState(() {
      start--;
      if(start <= 0){
        start = 0;
      }
    });
  }

  void sumOf({required int x, required int y}){
    setState(() {
      result = x + y;
    });
  }

  void resetResult(){
    setState(() {
      input1Controller.text = "";
      input2Controller.text = "";
      result = 0;
    });
  }

  @override
  void dispose() {
    input1Controller.dispose();
    input2Controller.dispose();
    messageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mcs Bab 1", style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xff102C57),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 32,),

          Center(
            child: Text(start.toString(), style: const TextStyle(fontSize: 50),),
          ),

          const SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: (){decrement();},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFF8343),
                ),
                child: const Icon(Icons.arrow_back_ios, color: Colors.black,),
              ),

              ElevatedButton(
                onPressed: (){increment();},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff55679C),
                ),
                child: const Icon(Icons.arrow_forward_ios, color: Colors.black,),

              ),
            ],
          ),

          const SizedBox(height: 32,),

          //input1
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: input1Controller,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24,),

          //input2
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: input2Controller,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24,),
          
          //sumButton
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: (){
                    sumOf(
                      x: int.parse(input1Controller.text),
                      y: int.parse(input2Controller.text),
                    );
                  },
                  child: const Text(
                    "+",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 24,),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "result :",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Text(
                  "$result",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24,),

          //reset result
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: const Icon(Icons.restart_alt),
                  onTap: (){resetResult();},
                )
              ],
            ),
          ),

          const SizedBox(height: 24,),

          //send message
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8,),

                GestureDetector(
                  child: const Icon(Icons.send),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Receiver(message: messageController.text),),
                    );
                  },
                )
              ],
            ),
          ),

          const SizedBox(height: 24,),

          Center(
            child: GestureDetector(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff604CC3)
                ),
                child: Text(flutterUrl, style: const TextStyle(color: Colors.white),),
              ),
              onTap: ()async{
                await launchUrl(Uri.parse(flutterUrl));
              },
            ),
          )
        ],
      ),
    );
  }
}