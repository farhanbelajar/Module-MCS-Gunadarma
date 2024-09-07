import 'package:flutter/material.dart';
import 'package:mcs_bab_5/providers/app_provider.dart';
import 'package:mcs_bab_5/services/api_service.dart';
import 'package:provider/provider.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Agro Tech"),
            centerTitle: true,
            backgroundColor: appProvider.mainColor,
          ),
          body: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 8,
                ),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: appProvider.mainColor, width: 4),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          child: Image.asset(appProvider.thermoMeter, fit: BoxFit.fill,),
                        ),
                        const Center(
                          child: Text("data1"),
                          // child: FutureBuilder(
                          //   future: ApiService().getField1(),
                          //   builder: builder,
                          // ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: appProvider.mainColor, width: 4),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.width / 5,
                          child: Image.asset(appProvider.thermoMeter, fit: BoxFit.fill,),
                        ),
                        const Center(
                          child: Text("data1"),
                          // child: FutureBuilder(
                          //   future: ApiService().getField1(),
                          //   builder: builder,
                          // ),
                        )
                      ],
                    ),
                  )
                ],
              ),

            ),
          ),
        );
      },
    );
  }
}
