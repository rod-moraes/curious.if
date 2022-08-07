import 'dart:convert';
import '../../../core/core.dart';
import '../../../services/client/client_service.dart';
import '../model/sign_up_model.dart';

abstract class ISignUpRepository {
  Future<String> signUp(SignUpModel signUpModel);
  void dispose();
}

class SignUpRepository implements ISignUpRepository {
  final ClientService _datasource;
  final String server = UtilsConst.server;

  SignUpRepository(ClientService datasource) : _datasource = datasource;

  @override
  Future<String> signUp(SignUpModel signUpModel) async {
    try {
      String response = await _datasource.post(
        Uri.parse("${server}api/users/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': signUpModel.name,
          'password': signUpModel.password,
          'email': signUpModel.email
        }),
      );
      Map<String, dynamic> responseMap = jsonDecode(response);
      if (responseMap["email"] is String) {
        return responseMap["email"];
      } else {
        return "";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _datasource.dispose();
  }
}
