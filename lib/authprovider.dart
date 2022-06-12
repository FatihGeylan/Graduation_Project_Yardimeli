import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Model/ModelAuth.dart';

class Authstate extends ChangeNotifier{
  Auth? auth;
}

final authProvider =ChangeNotifierProvider((ref){
  return Authstate();
});