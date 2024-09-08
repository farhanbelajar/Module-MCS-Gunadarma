import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcs_bab_5/models/field1_model.dart';
import 'package:mcs_bab_5/screens/main_screen.dart';
import 'package:mcs_bab_5/services/api_service.dart';
import '../models/field2_model.dart';
import '../models/field3_model.dart';

class AppProvider extends ChangeNotifier {
  TextStyle roboto14Italic = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400,);
  TextStyle roboto14 = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500,);
  TextStyle roboto14SemiBold = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600,);
  TextStyle roboto14Bold = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w700,);
  TextStyle roboto16Italic = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400,);
  TextStyle roboto16 = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500,);
  TextStyle roboto16SemiBold = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600,);
  TextStyle roboto16Bold = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700,);

  TextStyle whiteRoboto14Bold = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white);

  Color mainColor = const Color(0xff36725D);
  String loremIpsum =
  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  String thermoMeter = "images/thermometer.png";
  String humiditySensor = "images/humidity-sensor.png";
  String soilAnalysis = "images/soil-analysis.png";
  String power = "images/power.png";
  Field1Model? field1model;
  Field2Model? field2model;
  Field3Model? field3model;

  gotoMainScreen({required BuildContext context}){
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => const MainScreen(),),
    );
    notifyListeners();
  }

  Future getTemperature() async{
    notifyListeners();
    return field1model = await ApiService().getField1();
  }

  Future getHumidity() async{
    notifyListeners();
    return field2model = await ApiService().getField2();
  }

  Future getSoilMoisture() async{
    notifyListeners();
    return field3model = await ApiService().getField3();
  }
}