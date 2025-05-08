import 'package:shared_preferences/shared_preferences.dart';

const String ID = '_id';
const String FULLNAME = 'FullName';
const String EMAIL = 'Email';
const String MOBILE = 'Mobile';
const String PASSWORD = 'Password';
const String DOB = 'Dob';
const String GENDER = 'Gender';
const String CITY = 'City';
const String HOBBY = 'Hobby';
const String ISFAVORITE = 'IsFavorite';
const String USERTABLE = 'Users';
const String AGE = 'Age';
const String HOBBIESTABLE = 'HobbiesTable';
const String USER_HOBBIESTABLE = 'User_HobbiesTable';
const String ISDARK = 'isDark';
bool isDark = false;
Future<bool> getIsDark() async{
  SharedPreferences pre = await SharedPreferences.getInstance();
  bool ? isDarkMode = pre.getBool(ISDARK);
  return isDarkMode ?? false;
}

Future<bool> setIsDark({required bool isDark})async{
  SharedPreferences pre = await SharedPreferences.getInstance();
  pre.setBool(ISDARK, !isDark);
  return !isDark;
}

void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
}

void printResultText(String text) {
  print('\x1B[31m$text\x1B[0m');
}
