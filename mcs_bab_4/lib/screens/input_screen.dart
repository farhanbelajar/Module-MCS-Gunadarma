import 'package:flutter/material.dart';
import 'package:mcs_bab_4/models/model.dart';
import 'package:mcs_bab_4/providers/app_provider.dart';
import 'package:provider/provider.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("MCS Bab 4"),),
          body: ListView(
            children: [
              const SizedBox(height: 14,),

              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width/3,
                  height: MediaQuery.of(context).size.width/3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.black, width: 1,),
                    // color: Colors.red,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: appProvider.image != null?
                    Image.file(appProvider.image!, fit: BoxFit.fill,) :
                    const Center(child: Text("upload photo")),
                  )
                ),
              ),

              const SizedBox(height: 14,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: const Icon(Icons.camera),
                    onTap: () async{await appProvider.imageFromCamera();},
                  ),
                  GestureDetector(
                    child: const Icon(Icons.image),
                    onTap: () async{await appProvider.imageFromGallery();},
                  ),
                ],
              ),

              const SizedBox(height: 14,),

              //input npm
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: TextFormField(
                  controller: appProvider.inputNpmController,
                  decoration: InputDecoration(
                    label: Text(appProvider.npmLabel),
                  ),
                ),
              ),

              const SizedBox(height: 14,),

              //input name
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: TextFormField(
                  controller: appProvider.inputNameController,
                  decoration: InputDecoration(
                    label: Text(appProvider.nameLabel),
                  ),
                ),
              ),

              const SizedBox(height: 14,),

              //input desc
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: TextFormField(
                  controller: appProvider.inputDescController,
                  decoration: InputDecoration(
                    label: Text(appProvider.descLabel),
                  ),
                  maxLines: 2,
                ),
              ),

              const SizedBox(height: 40,),

              Center(
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14, horizontal: 18,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff0F6292),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: const Text(
                      "add data", style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: (){appProvider.addData();},
                ),
              ),

              const SizedBox(height: 40,),

              ListView.builder(
                itemCount: appProvider.data.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Model model = appProvider.data[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6 ,horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${model.npm}",),
                        GestureDetector(
                          child: const Icon(Icons.arrow_forward),
                          onTap: () => appProvider.goToProfileScreen(
                            context: context,
                            image: model.image!,
                            npm: model.npm!,
                            name: model.name!,
                            desc: model.desc!,
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        );
      },

    );
  }
}