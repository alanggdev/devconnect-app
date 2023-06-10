import 'package:dev_connect_app/env_keys.dart';
import 'package:dev_connect_app/features/profile/data/models/profile_model.dart';
import 'package:dev_connect_app/features/profile/data/models/profile_post_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

String apiURI = EnvKeys.serverURI;

abstract class ProfileDatasource {
  Future<ProfileModel> getProfile(int userid);
  Future<List<ProfilePostModel>> getProfilePosts(int userid);
}

class ProfileDatasourceImp implements ProfileDatasource {
  @override
  Future<ProfileModel> getProfile(int userid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? access = prefs.getString('access');

    var url = Uri.https(apiURI, 'userprofile/user/$userid');
    var headers = {'Authorization': 'Bearer $access'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var reponseData = convert.jsonDecode(response.body);
      return ProfileModel.fromJson(reponseData['pay_load'][0]);
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<ProfilePostModel>> getProfilePosts(int userid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? access = prefs.getString('access');

    var url = Uri.https(apiURI, 'post/user/$userid');
    var headers = {'Authorization': 'Bearer $access'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<ProfilePostModel> profilePostList = [];
      var responseDecoded = convert.jsonDecode(response.body);
      var payLoad = responseDecoded['pay_load'];

      if (payLoad.length > 0) {
        for (var object in payLoad) {
          if (object['media'] == null) {
            ProfilePostModel profilePostModelTemp = ProfilePostModel.fromJson(object);
            profilePostList.add(profilePostModelTemp);
          } else {
            ProfilePostModel profilePostModelTemp = ProfilePostModel.fromJsonMedia(object);
            profilePostList.add(profilePostModelTemp);
          }
        }
        return profilePostList;
      } else {
        return profilePostList;
      }
    } else {
      throw Exception();
    }
  }
}
