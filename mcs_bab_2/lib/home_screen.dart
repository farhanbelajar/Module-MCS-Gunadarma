import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcs_bab_2/cat_data.dart';
import 'package:mcs_bab_2/cat_model.dart';
import 'package:mcs_bab_2/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mcs Bab 2", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey[900],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 32,),
          
          Center(
            child: Text(
              "Jenis-jenis Kucing",
              style: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 24,),

          ListView.builder(
            itemCount: cats.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              CatModel cat = cats[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 18),
                child: GestureDetector(
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width/4,
                        width: MediaQuery.of(context).size.width/4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(cat.urlImage, fit: BoxFit.cover,),
                        ),
                      ),
                      const SizedBox(width: 14,),
                      Text(cat.name),
                    ],
                  ),
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) {
                        return DetailScreen(cat: cat);
                      },),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}