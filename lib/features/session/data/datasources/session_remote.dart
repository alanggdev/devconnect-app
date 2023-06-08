import 'package:dev_connect_app/env_keys.dart';
import 'package:dev_connect_app/features/session/data/models/sign_in_model.dart';
import 'package:dev_connect_app/features/session/data/models/sign_up_model.dart';
import 'package:dev_connect_app/features/session/data/models/user_model.dart';
import 'package:dev_connect_app/features/session/domain/entities/sign_in.dart';
import 'package:dev_connect_app/features/session/domain/entities/sign_up.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

String apiURI = EnvKeys.serverURI;

abstract class SignInDatasource {
  Future<String> login(SignIn singInData);
}

abstract class SignUpDatasource {
  Future<String> register(SignUp signUpData);
}

class SignInDatasourceImpl implements SignInDatasource {
  @override
  Future<String> login(SignIn singInData) async {
    var url = Uri.https(apiURI, '/auth/login/');
    var headers = {'Content-Type': 'application/json'};

    dynamic body = SignInModel.fromEntityToJson(singInData);
    var response =
        await http.post(url, body: convert.jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      var reponseData = convert.jsonDecode(response.body);
      UserModel responseDataUser = UserModel.fromJson(reponseData);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('id', reponseData['user']['pk']);
      await prefs.setString('access', responseDataUser.access);
      await prefs.setString('refresh', responseDataUser.refresh);
      return "Success";
    } else if (response.statusCode == 400) {
      var reponseData = convert.jsonDecode(response.body);
      if (reponseData['non_field_errors'][0] ==
          "Unable to log in with provided credentials.") {
        return "Bad Credentials";
      } else {
        throw Exception();
      }
    } else {
      throw Exception();
    }
  }
}

class SignUpDatasourceImpl implements SignUpDatasource {
  @override
  Future<String> register(SignUp singUpData) async {
    var urlUser = Uri.https(apiURI, '/auth/signup/');
    var headers = {'Content-Type': 'application/json'};

    dynamic bodyUser = SignUpModel.fromEntityToJsonUser(singUpData);
    var responseUser = await http.post(urlUser,
        body: convert.jsonEncode(bodyUser), headers: headers);
    if (responseUser.statusCode == 201) {
      var responseUserData = convert.jsonDecode(responseUser.body);
      final userProfileData = {
        'user_profile': responseUserData['user']['pk'],
        'user_description': singUpData.description,
        'user_status': singUpData.status
      };

      var request = http.MultipartRequest(
          'POST', Uri.parse('https://$apiURI/userprofile/create/'));
      request = jsonToFormData(request, userProfileData);
      request.headers['X-Requested-With'] = "XMLHttpRequest";
      request.headers['Authorization'] = "Bearer ${responseUserData['access']}";

      request.files.add(await http.MultipartFile.fromPath(
          'user_avatar', singUpData.avatar.path));

      final responseProfile = await request.send();
      if (responseProfile.statusCode == 200) {
        return "Success";
      } else {
        throw Exception();
      }
    } else {
      throw Exception();
    }
  }

  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }
}
