class UserConstant {
  static String base = 'http://yardimeli.somee.com';
  static var api = base + '/api/Auth/CreateToken';

  Map<String,String> headers = {
    "Content-Type": "application/json; charset=UTF-8" };

}
