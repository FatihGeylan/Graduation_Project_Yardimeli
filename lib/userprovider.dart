import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Model/ModelUser.dart';

class Userstate extends ChangeNotifier{
  User? user;
}

final userProvider =ChangeNotifierProvider((ref){
  return Userstate();
});