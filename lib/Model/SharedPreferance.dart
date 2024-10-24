import 'package:shared_preferences/shared_preferences.dart';

Future<String> SharedToken() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("token")!;
}
Future<String> SharedEmail() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("email")!;
}
Future<String> SharedImage() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("photo_profile")!;
}
Future<String> SharedName() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("name")!;
}

Future<String> SharedUsername() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("username")!;
}
