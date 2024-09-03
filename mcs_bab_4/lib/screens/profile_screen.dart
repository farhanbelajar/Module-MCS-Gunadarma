import 'package:flutter/material.dart';
import 'package:mcs_bab_4/providers/app_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Mhs Profile"),),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.file(appProvider.imageProfile!),

                const SizedBox(height: 20,),

                Text("${appProvider.npm!}"),

                const SizedBox(height: 20,),

                Text("${appProvider.name}"),

                const SizedBox(height: 20,),

                Text("${appProvider.desc}"),
              ],
            ),
          )
        );
      },
    );
  }
}