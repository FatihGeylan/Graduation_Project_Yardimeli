import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yardimeliflutter/API/GetUserApiService.dart';
import 'package:yardimeliflutter/Model/ModelUser.dart';
import 'package:yardimeliflutter/authprovider.dart';

class UserRepository extends ChangeNotifier{

  Usermodel usermodel = new Usermodel();
  User user = new User(Id: '', Email: '', UserName: '', City: '', Balance: -1, FirstName: '', LastName: '');

  Future<void> getUser(Authstate authstate) async {
    usermodel = (await userApiService().getUser(authstate))!;
    user = usermodel.data!;
    notifyListeners();
  }
}
final userProvider = ChangeNotifierProvider((ref){
  return UserRepository();
});