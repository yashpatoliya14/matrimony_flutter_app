import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import './standard.dart';

class User {
  static bool searchBarState = false;
  static List<Map<String, dynamic>> userList = [];
  Future<Database> initDatabase() async {
    var db = await openDatabase('matrimony3.db',
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE $USERTABLE('
                  'UserId INTEGER PRIMARY KEY AUTOINCREMENT, '
                  '$FULLNAME TEXT, '
                  '$EMAIL TEXT, '
                  '$MOBILE INTEGER, '
                  '$DOB DATETIME, '
                  '$CITY TEXT, '
                  '$GENDER TEXT, '
                  '$PASSWORD TEXT, '
                  '$ISFAVORITE INTEGER, '
                  '$AGE INTEGER'
                  ')'
          );
          await db.execute(
              '''
            CREATE TABLE $HOBBIESTABLE (
              HobbyId INTEGER PRIMARY KEY AUTOINCREMENT,
              $HOBBY TEXT UNIQUE
            )  
          '''
          );

          await db.execute(
              '''
            CREATE TABLE $USER_HOBBIESTABLE (
              UserId INTEGER, 
              HobbyId INTEGER, 
              PRIMARY KEY (UserId, HobbyId),
              FOREIGN KEY (UserId) REFERENCES $USERTABLE(UserId) ON DELETE CASCADE,
              FOREIGN KEY (HobbyId) REFERENCES $HOBBIESTABLE(HobbyId) ON DELETE CASCADE
            )  
          '''
          );
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await db.execute('''
            ALTER TABLE $USERTABLE ADD COLUMN $AGE INTEGER
          ''');
          }
        },
        version: 2);
    return db;
  }

  // Future<int> addUser({required Map<String, dynamic> map}) async {
  //   Database db = await initDatabase();
  //
  //   Map<String, dynamic> user = {};
  //   user[FULLNAME] = map[FULLNAME];
  //   user[EMAIL] = map[EMAIL];
  //   user[MOBILE] = map[MOBILE];
  //   user[DOB] = map[DOB];
  //   user[CITY] = map[CITY];
  //   user[GENDER] = map[GENDER];
  //   user[PASSWORD] = map[PASSWORD];
  //   user[ISFAVORITE] = 0;
  //
  //   if (map[DOB] != null) {
  //     List<String> dobParts = map[DOB].split('/');
  //     if (dobParts.length == 3) {
  //       int day = int.parse(dobParts[0]);
  //       int month = int.parse(dobParts[1]);
  //       int year = int.parse(dobParts[2]);
  //       DateTime birthDate = DateTime(year, month, day);
  //       DateTime today = DateTime.now();
  //       int age = today.year - birthDate.year;
  //       if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
  //         age--;
  //       }
  //       user[AGE] = age;
  //     }
  //   }
  //
  //   // Insert the user record into the database.
  //   int userId = await db.insert(USERTABLE, user);
  //
  //   // Process and insert each hobby.
  //   for (String hobby in map[HOBBY]) {
  //     // Insert the hobby into the hobbies table (ignore duplicates).
  //     await db.insert(HOBBIESTABLE, {HOBBY: hobby}, conflictAlgorithm: ConflictAlgorithm.ignore);
  //
  //     // Query the hobby to get its ID.
  //     List<Map<String, dynamic>> hobbyResult = await db.query(
  //       HOBBIESTABLE,
  //       where: "$HOBBY = ?",
  //       whereArgs: [hobby],
  //     );
  //
  //     if (hobbyResult.isNotEmpty) {
  //       int hobbyId = hobbyResult.first['HobbyId'];
  //
  //       // Link the user and the hobby in the user_hobbies table.
  //       await db.insert(USER_HOBBIESTABLE, {
  //         'UserId': userId,
  //         'HobbyId': hobbyId,
  //       });
  //     }
  //   }
  //   return userId;
  // }

  Future<void> addUser({required Map<String, dynamic> map}) async {
    final url = Uri.parse("https://66a47a175dc27a3c1908fdc6.mockapi.io/yash");

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


  // Future<List<Map<String, dynamic>>> getUserList() async{
  //   Database db = await initDatabase();
  //   List<Map<String, dynamic>> userList = await db.query(USERTABLE);
  //   return userList;
  // }

  Future<List<Map<String, dynamic>>> getUserList() async{
      final url = Uri.parse("https://66a47a175dc27a3c1908fdc6.mockapi.io/yash");
      try {
        final response = await http.get(url);

        List<Map<String, dynamic>> userList = [];
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
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

  // Future<int> updateUser({required Map<String, dynamic> map, required int id}) async {
  //   Database db = await initDatabase();
  //
  //   Map<String, dynamic> user = {
  //     FULLNAME: map[FULLNAME],
  //     EMAIL: map[EMAIL],
  //     MOBILE: map[MOBILE],
  //     DOB: map[DOB],
  //     CITY: map[CITY],
  //     GENDER: map[GENDER],
  //     PASSWORD: map[PASSWORD],
  //     ISFAVORITE:map[ISFAVORITE]
  //   };
  //   if (map[DOB] != null) {
  //     List<String> dobParts = map[DOB].split('/');
  //     if (dobParts.length == 3) {
  //       int day = int.parse(dobParts[0]);
  //       int month = int.parse(dobParts[1]);
  //       int year = int.parse(dobParts[2]);
  //       DateTime birthDate = DateTime(year, month, day);
  //       DateTime today = DateTime.now();
  //       int age = today.year - birthDate.year;
  //       if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
  //         age--;
  //       }
  //       user[AGE] = age;
  //     }
  //   }
  //   int userId = await db.update(
  //     USERTABLE,
  //     user,
  //     where: 'UserId = ?',
  //     whereArgs: [id],
  //   );
  //
  //   if(map[HOBBY]!=null){
  //     await db.delete(
  //       USER_HOBBIESTABLE,
  //       where: "UserId = ?",
  //       whereArgs: [id],
  //     );
  //   }
  //
  //   for (String hobby in map[HOBBY]) {
  //     await db.insert(
  //       HOBBIESTABLE,
  //       {HOBBY: hobby},
  //       conflictAlgorithm: ConflictAlgorithm.ignore,
  //     );
  //
  //     List<Map<String, dynamic>> hobbyResult = await db.query(
  //       HOBBIESTABLE,
  //       where: "$HOBBY = ?",
  //       whereArgs: [hobby],
  //     );
  //
  //     if (hobbyResult.isNotEmpty) {
  //       int hobbyId = hobbyResult.first['HobbyId'];
  //
  //       await db.insert(
  //         USER_HOBBIESTABLE,
  //         {'UserId': id, 'HobbyId': hobbyId},
  //         conflictAlgorithm: ConflictAlgorithm.ignore,
  //       );
  //     }
  //   }
  //   return userId;
  // }

  Future<void> updateUser({required Map<String, dynamic> map, required int id}) async {
    final url = Uri.parse("https://66a47a175dc27a3c1908fdc6.mockapi.io/yash/$id");

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

    final response = await http.put(
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

  Future<List<String>> getUserHobbies({required int userId}) async {
    Database db = await initDatabase();

    // Query to fetch hobbies for a given user ID
    List<Map<String, dynamic>> hobbyResults = await db.rawQuery('''
    SELECT $HOBBY FROM $HOBBIESTABLE 
    INNER JOIN $USER_HOBBIESTABLE 
    ON $HOBBIESTABLE.HobbyId = $USER_HOBBIESTABLE.HobbyId
    WHERE $USER_HOBBIESTABLE.UserId = ?
  ''', [userId]);

    // Extracting hobby names into a list of strings
    List<String> hobbies = hobbyResults.map((hobby) => hobby[HOBBY] as String).toList();

    return hobbies;
  }


  // Future<int> deleteUser({required id}) async{
  //   Database db = await initDatabase();
  //   int userId =
  //       await db.delete(USERTABLE, where: 'UserId = ?', whereArgs: [id]);
  //   return userId;
  //
  // }

  Future<void> deleteUser({required id}) async{
    print(":::$id:::::");
    final url = Uri.parse("https://66a47a175dc27a3c1908fdc6.mockapi.io/yash/$id");
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

  Future<Map<String , dynamic>?> getUserForLogin({required String mobile,required String password}) async {
    try{
      Database db = await initDatabase();
      int mobileno = int.parse(mobile);
      List<Map<String, dynamic>> result = await db.rawQuery('''
        Select * from $USERTABLE 
        where $MOBILE = ? and $PASSWORD = ?
      ''', [mobileno, password]);
        return result[0];
    }catch(error){
      print("Error : ");
      print(error);
    }
    return null;
  }
}

