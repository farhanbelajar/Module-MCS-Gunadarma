import 'package:agrotech/models/field1_model.dart';
import 'package:flutter/material.dart';
import '../data/app_colors.dart';

class Temperature extends StatelessWidget {
  String icon;
  Stream stream;

  Temperature({
    super.key,
    required this.icon,
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
            child: Image.asset(icon, fit: BoxFit.fill,),
          ),
          Center(
            child: StreamBuilder(
              stream: stream,
              builder: (_, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return CircularProgressIndicator();
                // }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Text('No data');
                }
                Field1Model field = snapshot.data;
                return Text(field.field1);
              },
            ),)
        ],
      ),
    );
  }
}