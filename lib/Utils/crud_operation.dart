import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import './standard.dart';

class User {
  static bool searchBarState = false;
  static List<Map<String, dynamic>> userList = [];

  Future<void> addUser({required Map<String, dynamic> map}) async {
    final url = Uri.parse("http://192.168.51.147:3000/api/add");

    try{

    Map<String, dynamic> user = {};
    user[FULLNAME] = map[FULLNAME];
    user[EMAIL] = map[EMAIL];
    user[MOBILE] = map[MOBILE];
    user[DOB] = map[DOB];
    user[CITY] = map[CITY];
    user[GENDER] = map[GENDER];
    user[PASSWORD] = map[PASSWORD];
    user[ISFAVORITE] = false;
    user[HOBBY] = map[HOBBY];

    if (map[DOB] != null) {
      List<String> dobParts = map[DOB].split('/');
      if (dobParts.length == 3) {
        int day = int.parse(dobParts[0]);
        int month = int.parse(dobParts[1]);
        int year = int.parse(dobParts[2]);
        DateTime birthDate = DateTime(year, month, day);
        DateTime today = DateTime.now();
        int age = today.year - birthDate.year;
        if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
          age--;
        }
        user[AGE] = age;
      }
    }

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print('Post added successfully: $data');
    } else {
      print('Failed to add post. Status Code: ${response.statusCode}');
    }
    }catch(err){
        print("::: ERROR OCCURS  :::: \n $err");
    }

  }
  Future<List<Map<String, dynamic>>> getUserList() async{
      final url = Uri.parse("http://192.168.51.147:3000/api/get");
      try {
        final response = await http.get(url);
        print(response );
        print(":::::::::::::::::::::");
        List<Map<String, dynamic>> userList = [];
        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          final List<dynamic> data = jsonResponse['data'];
          print('Data fetched successfully: $data');

          for(int i =0; i<data.length; i++){
              userList.add(data[i]);
          }

          return userList;
        } else {
          print('::::::    Failed to fetch data. Status Code ::::::: ${response.statusCode}');
          return userList;
        }
      } catch (e) {
        print('::::: Error fetching data ::::: $e');
      }
      return userList;
  }


  Future<void> updateUser({required Map<String, dynamic> map, required String id}) async {
    print(map);
    print(id);

    final url = Uri.parse("http://192.168.51.147:3000/api/update/$id");

    try{

    Map<String, dynamic> user = {
      FULLNAME: map[FULLNAME],
      EMAIL: map[EMAIL],
      MOBILE: map[MOBILE],
      DOB: map[DOB],
      CITY: map[CITY],
      GENDER: map[GENDER],
      PASSWORD: map[PASSWORD],
      ISFAVORITE:map[ISFAVORITE],
      HOBBY:map[HOBBY],
    };

    if (map[DOB] != null) {
      List<String> dobParts = map[DOB].split('/');
      if (dobParts.length == 3) {
        int day = int.parse(dobParts[0]);
        int month = int.parse(dobParts[1]);
        int year = int.parse(dobParts[2]);
        DateTime birthDate = DateTime(year, month, day);
        DateTime today = DateTime.now();
        int age = today.year - birthDate.year;
        if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
          age--;
        }
        user[AGE] = age;
      }
    }

    final response = await http.patch(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      print('Post updated successfully: ${response.body}');
    } else {
      print('Failed to update post. Status Code: ${response.statusCode}');
    }
    }catch(err){
        print(":::: ERROR OCCURS :::: \n $err");
    }
  }

  Future<void> deleteUser({required id}) async{
    print(":::$id:::::");
    final url = Uri.parse("http://192.168.51.147:3000/api/delete/$id");
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Post deleted successfully');
      } else {
        print('Failed to delete post. Status Code: ${response.statusCode}');
      }

    } catch (e) {
      print('::::: Error fetching data ::::: $e');
    }

  }

}

