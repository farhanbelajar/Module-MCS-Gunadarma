import 'package:flutter/material.dart';
import 'package:mcs_bab_5/providers/app_provider.dart';
import 'package:mcs_bab_5/widgets/read_field.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Agro Tech" , style: appProvider.whiteRoboto14Bold,),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: appProvider.mainColor,
          ),
          body: Center(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // temperature
                ReadField(
                  result: appProvider.field1model!.field1,
                  color: appProvider.mainColor,
                  image: appProvider.thermoMeterImage,
                ),

                const SizedBox(height: 20,),

                //humidity
                ReadField(
                  result: appProvider.field2model!.field2,
                  color: appProvider.mainColor,
                  image: appProvider.humiditySensorImage,
                ),
                // Container(
                //   width: double.infinity,
                //   margin: const EdgeInsets.symmetric(horizontal: 24),
                //   padding: const EdgeInsets.symmetric(vertical: 18),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(24),
                //     border: Border.all(color: appProvider.mainColor, width: 4),
                //   ),
                //   child:
                //   Column(
                //     children: [
                //       SizedBox(
                //         width: MediaQuery.of(context).size.width / 5,
                //         height: MediaQuery.of(context).size.width / 5,
                //         child: Image.asset(appProvider.humiditySensor, fit: BoxFit.fill,),
                //       ),
                //       const SizedBox(height: 14,),
                //       Center(
                //         child: FutureBuilder(
                //           future: appProvider.getTemperature(),
                //           builder: (context, snapshot) {
                //             if(snapshot.hasData){
                //               return Text(appProvider.field1model!.field1);
                //             } else{
                //               return const Text("no data");
                //             }
                //           },
                //         ),
                //       )
                //     ],
                //   ),
                // ),

                const SizedBox(height: 20,),

                //soil moisture
                ReadField(
                  result: appProvider.field3model!.field3,
                  color: appProvider.mainColor,
                  image: appProvider.soilAnalysisImage,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}