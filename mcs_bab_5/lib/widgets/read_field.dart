import 'package:flutter/material.dart';

class ReadField extends StatelessWidget {
  String result;
  Color color;
  String image;

  ReadField({
    super.key,
    required this.result,
    required this.color,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color, width: 4),
      ),
      child:
      Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.width / 5,
            child: Image.asset(image, fit: BoxFit.fill,),
          ),
          const SizedBox(height: 14,),
          Center(child: Text(result),),
        ],
      ),
    );
  }
}