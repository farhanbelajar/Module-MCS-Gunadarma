import 'package:agrotech/services/api_service.dart';
import 'package:agrotech/widgets/humidity.dart';
import 'package:agrotech/widgets/relay.dart';
import 'package:agrotech/widgets/soil_moisture.dart';
import 'package:agrotech/widgets/temperature.dart';
import 'package:flutter/material.dart';
import '../data/app_colors.dart';
import '../data/fonts.dart';
import '../data/images.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int statusButton = 0;

  setStatusButton() async{
    if(statusButton==0){
      statusButton = await 1;
      for(int i=1;i<=26;i++){
        await ApiService().writeField4(val: statusButton.toString());
        print(statusButton);
        i;
      }
    } else{
      statusButton = await 0;
      for(int i=1;i<=26;i++){
        await ApiService().writeField4(val: statusButton.toString());
        print(statusButton);
        i;
      }
    }
  }

  Stream fetchDataField1() async*{
    while(true){
      yield await ApiService().getField1();
      await Future.delayed(const Duration(seconds: 1));
      setState(() {});
    }
  }

  Stream fetchDataField2() async*{
    while(true){
      yield await ApiService().getField2();
      await Future.delayed(const Duration(seconds: 1));
      setState(() {});
    }
  }

  Stream fetchDataField3() async*{
    while(true){
      yield await ApiService().getField3();
      await Future.delayed(const Duration(seconds: 1));
      setState(() {});
    }
  }

  Stream fetchDataField4() async*{
    while(true){
      yield await ApiService().getField4();
      await Future.delayed(const Duration(seconds: 1));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: (Text("Agro Tech", style: Fonts.whiteRoboto18SemiBold,)),
        backgroundColor: AppColors.mainColor,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
            ),
            children: [
              Temperature(
                icon: Images.thermoMeter,
                stream: fetchDataField1(),
              ),

              Humidity(
                icon: Images.humiditySensor,
                stream: fetchDataField2(),
              ),

              SoilMoisture(
                icon: Images.soilAnalysis,
                stream: fetchDataField3(),
              ),

              Relay(
                icon: Images.power,
                onTap: (){setStatusButton();},
                stream: fetchDataField4(),
              ),
            ],
          ),
        ),
      )
    );
  }
}