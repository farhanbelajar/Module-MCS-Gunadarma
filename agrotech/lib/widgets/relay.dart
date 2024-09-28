import 'package:flutter/material.dart';

import '../data/app_colors.dart';
import '../models/field4_model.dart';

class Relay extends StatelessWidget {
  String icon;
  Function() onTap;
  Stream stream;

  Relay({
    super.key,
    required this.icon,
    required this.onTap,
    required this.stream,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.mainColor, width: 4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width/5,
            height: MediaQuery.of(context).size.width/5,
            child: GestureDetector(
              child: Image.asset(icon, fit: BoxFit.fill,),
              onTap: (){onTap();},
            ),
          ),

          Center(
            child: StreamBuilder(
              stream: stream,
              builder: (_, snapshot) {
                if(snapshot.hasData){
                  Field4Model field = snapshot.data;
                  return Text(field.field4);
                } else{
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}