import 'package:flutter/material.dart';
import 'package:mcs_bab_2/cat_model.dart';

class DetailScreen extends StatefulWidget {
  CatModel cat;

  DetailScreen({super.key, required this.cat,});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Image.network(widget.cat.urlImage,),

          const SizedBox(height: 18,),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(widget.cat.name),
          ),

          const SizedBox(height: 18,),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(widget.cat.desc, textAlign: TextAlign.justify,),
          ),
        ],
      ),
    );
  }
}