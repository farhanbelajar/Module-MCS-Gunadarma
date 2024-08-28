import 'package:flutter/material.dart';

class Receiver extends StatefulWidget {
  String message;

  Receiver({
    super.key,
    required this.message,
  });

  @override
  State<Receiver> createState() => _ReceiverState();
}

class _ReceiverState extends State<Receiver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("the message :"),
            Text(widget.message),
          ],
        ),
      ),
    );
  }
}
