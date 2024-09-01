import 'package:flutter/material.dart';
import 'package:mcs_bab_3/catatan_model.dart';

class EditScreen extends StatefulWidget {
  CatatanModel catatanModel;

  EditScreen({
    super.key,
    required this.catatanModel,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [

        ],
      ),
    );
  }
}
