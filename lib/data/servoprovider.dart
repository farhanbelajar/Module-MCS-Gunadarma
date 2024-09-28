import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServoProvider with ChangeNotifier {
  String _datasServo = "";
  List<String> _cardIds = [];

  String get datasServo => _datasServo;
  List<String> get cardIds => _cardIds;

  // Fungsi untuk update status servo
  Future<void> putData(int data) async {
    String url = "https://srvo-cntrllr-production.up.railway.app/servo/$data";
    try {
      http.Response res = await http.put(Uri.parse(url));
      if (res.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(res.body);
        int srvStatus = jsonResponse['srvStatus'];

        _datasServo = srvStatus.toString();
        notifyListeners(); // Update UI jika ada perubahan
      } else {
        debugPrint("Failed: ${res.statusCode}, Body: ${res.body}");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  // Fungsi untuk fetch data cards dari API
  Future<void> fetchCardData() async {
    String url = 'https://card-bridge-production.up.railway.app/cards';
    try {
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(res.body);
        List<dynamic> result = jsonResponse['result'];

        _cardIds = result.map((item) => item['id'].toString()).toList();
        notifyListeners(); // Update UI jika ada perubahan
      } else {
        debugPrint("Failed to fetch cards: ${res.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching cards: $e");
    }
  }
}
