import 'package:shared_preferences/shared_preferences.dart';

Future<void> localStoreSetUId(String uId) async {
  final pref = await SharedPreferences.getInstance();
  pref.setString('u_id', uId);
}

Future<String> localStoreGetUId() async {
  final pref = await SharedPreferences.getInstance();
  dynamic test = pref.getString('u_id');
  return test ?? "";
}
