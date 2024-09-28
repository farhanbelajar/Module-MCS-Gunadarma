import 'package:agrotech/services/api_service.dart';
import 'package:agrotech/widgets/humidity.dart';
import 'package:agrotech/widgets/relay.dart';
import 'package:agrotech/widgets/soil_moisture.dart';
import 'package:agrotech/widgets/temperature.dart';
import 'package:flutter/material.dart';
import '../data/app_colors.dart';
import '../data/fonts.dart';
import '../data/images.dart';
import '../models/field1_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int statusButton = 0;

  setStatusButton() async {
    if (statusButton == 0) {
      statusButton = 1;
      for (int i = 1; i <=20; i++) {
        await ApiService().writeField4(val: statusButton.toString());
        print(statusButton);
        i;
      }
    } else {
      statusButton = 0;
      for (int i = 1; i <= 20; i++) {
        await ApiService().writeField4(val: statusButton.toString());
        print(statusButton);
        i;
      }
    }
  }

  Stream fetchDataField1() async* {
    while (true) {
      yield await ApiService().getField1();
      await Future.delayed(const Duration(seconds: 1));
      setState(() {});
    }
  }

  Stream fetchDataField2() async* {
    while (true) {
      yield await ApiService().getField2();
      await Future.delayed(const Duration(seconds: 1));
      setState(() {});
    }
  }

  Stream fetchDataField3() async* {
    while (true) {
      yield await ApiService().getField3();
      await Future.delayed(const Duration(seconds: 1));
      setState(() {});
    }
  }

  Stream fetchDataField4() async* {
    while (true) {
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
          title: (Text(
            "Agro Tech",
            style: Fonts.whiteRoboto18SemiBold,
          )),
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
                // Temperature(
                //   icon: Images.thermoMeter,
                //   stream: fetchDataField1(),
                // ),

                //temperature
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.mainColor, width: 4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                        height: MediaQuery.of(context).size.width / 5,
                        child: Image.asset(
                          Images.thermoMeter,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Center(
                        child: StreamBuilder(
                          stream: fetchDataField1(),
                          builder: (_, snapshot) {
                            // if (snapshot.connectionState == ConnectionState.waiting) {
                            //   return CircularProgressIndicator();
                            // }
                            if (snapshot.hasError) {
                              // return Text('Error: ${snapshot.error}');
                              return const Text('Error');
                            }
                            if (!snapshot.hasData || snapshot.data == null) {
                              return const Text('No data');
                            }
                            Field1Model field = snapshot.data;
                            return Text(field.field1);
                          },
                        ),
                      )
                    ],
                  ),
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
                  onTap: () {
                    setStatusButton();
                  },
                  stream: fetchDataField4(),
                ),
              ],
            ),
          ),
        ));
  }
}