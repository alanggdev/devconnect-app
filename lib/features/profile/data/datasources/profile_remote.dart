import 'package:dev_connect_app/env_keys.dart';
import 'package:dev_connect_app/features/profile/data/models/profile_model.dart';
import 'package:dev_connect_app/features/profile/data/models/profile_post_model.dart';
import 'package:dev_connect_app/features/profile/domain/entities/profile.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

String apiURI = EnvKeys.serverURI;

abstract class ProfileDatasource {
  Future<ProfileModel> getProfile(int userid);
  Future<List<ProfilePostModel>> getProfilePosts(int userid);
  Future<void> updateProfile(int profileid, int userid, int profileuserid);
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
            ProfilePostModel profilePostModelTemp =
                ProfilePostModel.fromJson(object);
            profilePostList.add(profilePostModelTemp);
          } else {
            ProfilePostModel profilePostModelTemp =
                ProfilePostModel.fromJsonMedia(object);
            profilePostList.add(profilePostModelTemp);
          }
        }

        profilePostList.sort((a, b) {
          // Parse the date strings into DateTime objects
          DateTime dateA = DateFormat('dd/MM/yyyy hh:mma').parse(a.date);
          DateTime dateB = DateFormat('dd/MM/yyyy hh:mma').parse(b.date);

          // Compare the dates
          return dateB.compareTo(dateA);
        });

        return profilePostList;
      } else {
        return profilePostList;
      }
    } else {
      throw Exception();
    }
  }

  @override
  Future<void> updateProfile(
      int profileid, int userid, int profileuserid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? access = prefs.getString('access');

    var url = Uri.https(apiURI, '/userprofile/update/$profileid');
    var headers = {
      'Authorization': 'Bearer $access',
      'Content-Type': 'application/json'
    };

    getProfile(profileuserid).then((userProfile) {
      List<dynamic> followers = userProfile.followers;
      if (followers.contains(userid)) {
        followers.remove(userid);
      } else {
        followers.add(userid);
      }

      Map<String, dynamic> json = {
        'user_profile': profileuserid,
        'user_followers': followers
      };

      http
          .patch(url, body: convert.jsonEncode(json), headers: headers)
          .then((response) {
        // getProfileToFollowing
        getProfile(userid).then((userProfileNew) {
          List<dynamic> following = userProfileNew.following;
          if (following.contains(profileuserid)) {
            following.remove(profileuserid);
          } else {
            following.add(profileuserid);
          }

          Map<String, dynamic> jsonNew = {
            'user_profile': userProfileNew.userId,
            'user_following': following
          };

          var url =
              Uri.https(apiURI, '/userprofile/update/${userProfileNew.id}');

          http.patch(url, body: convert.jsonEncode(jsonNew), headers: headers);
        });
      });
    });
  }
}
