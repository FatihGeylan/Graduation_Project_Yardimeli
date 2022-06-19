import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Model/ModelAuth.dart';

class Authstate extends ChangeNotifier{
  static final Authstate _authstate=Authstate.initilazier();
  factory Authstate(){
    return _authstate;
  }
  Authstate.initilazier();
  Auth? auth;
}

final authProvider =ChangeNotifierProvider((ref){
  return Authstate();
});