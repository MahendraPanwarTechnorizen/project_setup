import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project_setup/Screen/SqliteCurdScreen.dart';
import 'package:project_setup/Utils/createRoute.dart';

class AuthProvider extends ChangeNotifier{
  bool loading =false;


  Future<void> clickOnLogin(email,password,context) async {
      var url = Uri.parse('https://reqres.in/api/login'); // Replace with your API endpoint
      var headers = {'Content-Type': 'application/json'}; // Set appropriate headers
      var bodyData = {'email':email, 'password': password};
      loading=true;
      notifyListeners();
      try {
        var response = await http.post(
          url,
          headers: headers,
          body: json.encode(bodyData),
        );
        loading=false;
        notifyListeners();
        if (response.statusCode == 200) {
          print('POST request successful! Response: ${response.body}');
          Navigator.pushReplacement(context, createRoute(CurdOperation()));
        } else {
          print('Failed to make POST request. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error making POST request: $error');
      }

  }

}