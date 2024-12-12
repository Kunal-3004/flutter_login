import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_login/constant/utils.dart';

Future<Map<String, dynamic>> userLogin(String email, String password) async {
  try {
    final url = Uri.parse('${Utils.baseUrl}/user/login');
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"email": email, "password": password}),
    );
    if (response.statusCode != 200) {
      return {"success": false, "message": "Error: ${response.statusCode}"};
    }
    final decodedData = jsonDecode(response.body);
    return decodedData;
  } catch (e) {
    return {"success": false, "message": "An error occurred: $e"};
  }
}

Future userRegister(String name, String email, String password) async{
  try {
    final url = Uri.parse('${Utils.baseUrl}/user/register');
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"name": name,"email": email, "password": password}),
    );
    if (response.statusCode != 200) {
      return {"success": false, "message": "Error: ${response.statusCode}"};
    }
    final decodedData = jsonDecode(response.body);
    return decodedData;
  } catch (e) {
    return {"success": false, "message": "An error occurred: $e"};
  }
}
