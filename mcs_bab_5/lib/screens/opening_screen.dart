import 'package:flutter/material.dart';
import 'package:mcs_bab_5/providers/app_provider.dart';
import 'package:provider/provider.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({super.key});

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {

  @override
  void initState() {
    Provider.of<AppProvider>(context, listen: false,).getTemperature();
    Provider.of<AppProvider>(context, listen: false,).getHumidity();
    Provider.of<AppProvider>(context, listen: false,).getSoilMoisture();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          appBar: AppBar(
          title: Text("Agro Tech" , style: appProvider.whiteRoboto14Bold,),
            centerTitle: true,
            backgroundColor: appProvider.mainColor,
          ),
          body: Center(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Text(
                    appProvider.loremIpsum,
                    style: appProvider.roboto14Bold,
                    textAlign: TextAlign.justify,),
                ),

                const SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: appProvider.mainColor,
                        ),
                        child: Text("Continue", style: appProvider.whiteRoboto14Bold,),
                      ),
                      onTap: () {
                        appProvider.gotoMainScreen(context: context);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}