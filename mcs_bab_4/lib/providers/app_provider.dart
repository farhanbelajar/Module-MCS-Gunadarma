import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:mcs_bab_4/models/model.dart';
import 'package:mcs_bab_4/screens/profile_screen.dart';

class AppProvider extends ChangeNotifier{
  List<Model> data = [];
  io.File? image;
  ImagePicker imagePicker = ImagePicker();
  TextEditingController inputNpmController = TextEditingController();
  TextEditingController inputNameController = TextEditingController();
  TextEditingController inputDescController = TextEditingController();
  String npmLabel = 'Npm :';
  String nameLabel = 'Name :';
  String descLabel = 'Desc :';
  int? index;
  io.File? imageProfile;
  int? npm;
  String? name;
  String? desc;

  @override
  void dispose(){
    super.dispose();
    inputNpmController.dispose();
    inputNameController.dispose();
    inputDescController.dispose();
  }

  imageFromCamera() async{
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    io.File image = io.File(pickedFile!.path);
    this.image = image;
    notifyListeners();
  }

  imageFromGallery() async{
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    io.File image = io.File(pickedFile!.path);
    this.image = image;
    notifyListeners();
  }

  addData() async{
    data.add(
        Model(
          image: image,
          npm: int.parse(inputNpmController.text),
          name: inputNameController.text,
          desc: inputDescController.text,
        ));
    image = null;
    inputNpmController.text = "";
    inputNameController.text = "";
    inputDescController.text = "";
    notifyListeners();
  }

  deleteData({
    required BuildContext context,
  }) async{
    await data.removeAt(index!);
    Navigator.pop(context);
    notifyListeners();
  }

  goToProfileScreen({
    required BuildContext context,
    required int index,
    required Model model,
  }) async{
    this.index = index;
    imageProfile = await model.image;
    npm = await model.npm;
    name = await model.name;
    desc = await model.desc;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen(),),
    );
    notifyListeners();
  }
}