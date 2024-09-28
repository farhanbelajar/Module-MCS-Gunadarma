import 'package:agrotech/models/field1_model.dart';
import 'package:dio/dio.dart';
import '../models/field2_model.dart';
import '../models/field3_model.dart';
import '../models/field4_model.dart';

class ApiService{
  Dio dio = Dio();

  String readKey = "UQPUBO93XAN2JO24";
  String writeKey = "G8W8X9I594AJQSK1";

  String field1Url = "https://api.thingspeak.com/channels/2610896/fields/1/last.json?api_key=UQPUBO93XAN2JO24";
  String field2Url = "https://api.thingspeak.com/channels/2610896/fields/2/last.json?api_key=UQPUBO93XAN2JO24";
  String field3Url = "https://api.thingspeak.com/channels/2610896/fields/3/last.json?api_key=UQPUBO93XAN2JO24";
  String field4Url = "https://api.thingspeak.com/channels/2610896/fields/4/last.json?api_key=UQPUBO93XAN2JO24";

  // String writeField4Url = "https://api.thingspeak.com/update?api_key=FQMB23HD35L4NGXG&field4=";
  String writeField4Url = "https://api.thingspeak.com/update?api_key=G8W8X9I594AJQSK1&field4=";

  Future<Field1Model> getField1() async{
    try{
      final response = await dio.get(field1Url);
      return Field1Model.fromJson(response.data);
    } catch(e){
     rethrow;
    }
  }

  Future<Field2Model> getField2() async{
    try{
      // final response = await dio.get(field2Url);
      final response = await dio.get("https://api.thingspeak.com/channels/2610896/fields/2/last.json?api_key=$readKey");
      return Field2Model.fromJson(response.data);
    } catch(e){
      rethrow;
    }
  }

  Future<Field3Model> getField3() async{
    try{
      final response = await dio.get(field3Url);
      return Field3Model.fromJson(response.data);
    } catch(e){
      rethrow;
    }
  }

  Future<Field4Model> getField4() async{
    try{
      final response = await dio.get(field4Url);
      return Field4Model.fromJson(response.data);
    } catch(e){
      rethrow;
    }
  }

  writeField4({
    required String val,
  }) async{
    try{
      final response = await dio.get("$writeField4Url$val");
      return response.data;
    } catch(e){
      rethrow;
    }
  }
}