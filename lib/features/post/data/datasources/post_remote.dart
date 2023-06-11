import 'package:dev_connect_app/env_keys.dart';
import 'package:dev_connect_app/features/post/data/models/post_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

String apiURI = EnvKeys.serverURI;

abstract class PostDatasource {
  Future<String> updatePost(int postid, int userid);
  Future<PostModel> getPostDetail(int postid);
  Future<List<PostModel>> getAllPosts();
}

class PostDatasourceImpl implements PostDatasource {
  @override
  Future<String> updatePost(int postid, int userid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? access = prefs.getString('access');

    var url = Uri.https(apiURI, '/post/update/$postid');
    var headers = {
      'Authorization': 'Bearer $access',
      'Content-Type': 'application/json'
    };

    getPostDetail(postid).then((postToupdate) {
      List<dynamic>? likes = postToupdate.likes;
      if (likes!.contains(userid)) {
        likes.remove(userid);
      } else {
        likes.add(userid);
      }
      PostModel newPostToUpdate =
          PostModel(author: postToupdate.author, likes: likes);

      dynamic body = PostModel.fromEntityToJsonLikes(newPostToUpdate);

      http
          .patch(url, body: convert.jsonEncode(body), headers: headers)
          .then((response) {
        if (response.statusCode == 200) {
          return "Updated";
        }
      });
    });
    return "Updated with something else (check backend)";
  }

  @override
  Future<PostModel> getPostDetail(int postid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? access = prefs.getString('access');

    var url = Uri.https(apiURI, '/post/detail/$postid');
    var headers = {'Authorization': 'Bearer $access'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var reponseData = convert.jsonDecode(response.body);
      return PostModel.fromJson(reponseData['pay_load']);
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? access = prefs.getString('access');

    var url = Uri.https(apiURI, '/post/list');
    var headers = {'Authorization': 'Bearer $access'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<PostModel> postList = [];
      var responseDecoded = convert.jsonDecode(response.body);
      var payLoad = responseDecoded['pay_load'];

      if (payLoad.length > 0) {
        for (var object in payLoad) {
          if (object['media'] == null) {
            PostModel profilePostModelTemp = PostModel.fromJson(object);
            postList.add(profilePostModelTemp);
          } else {
            PostModel profilePostModelTemp = PostModel.fromJsonMedia(object);
            postList.add(profilePostModelTemp);
          }
        }

        postList.sort((a, b) {
          // Parse the date strings into DateTime objects
          DateTime dateA = DateFormat('dd/MM/yyyy hh:mma').parse(a.date!);
          DateTime dateB = DateFormat('dd/MM/yyyy hh:mma').parse(b.date!);

          // Compare the dates
          return dateB.compareTo(dateA);
        });

        return postList;
      } else {
        return postList;
      }
    } else {
      throw Exception();
    }
  }
}
