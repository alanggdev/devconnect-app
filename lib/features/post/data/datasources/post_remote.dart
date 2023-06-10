import 'package:dev_connect_app/env_keys.dart';
import 'package:dev_connect_app/features/post/data/models/post_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

String apiURI = EnvKeys.serverURI;

abstract class PostDatasource {
  Future<String> updatePost(int postid, int userid);
  Future<PostModel> getDetailPost(int postid);
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

    getDetailPost(postid).then((postToupdate) {
      List<dynamic>? likes = postToupdate.likes;
      if (likes!.contains(userid)) {
        likes.remove(userid);
      } else {
        likes.add(userid);
      }
      PostModel newPostToUpdate =
          PostModel(author: postToupdate.author, likes: likes);

      dynamic body = PostModel.fromEntityToJsonLikes(newPostToUpdate);

      http.patch(url, body: convert.jsonEncode(body), headers: headers).then((response) {
        // var responseDecoded = convert.jsonDecode(response.body);
        if (response.statusCode == 200) {
          return "Updated";
        }
      });
    });
    throw Exception('Error');
  }

  @override
  Future<PostModel> getDetailPost(int postid) async {
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
}
