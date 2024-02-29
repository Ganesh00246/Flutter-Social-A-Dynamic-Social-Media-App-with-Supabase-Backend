import 'package:clone/models/user_model.dart';

import 'likes_model.dart';

class PostModel {
  int? id;
  String? content;
  String? image;
  String? createdAt;
  int? commentCount;
  int? likeCount;
  String? userId;
  UserModel? user;
  List<LikesModel>? likes;

  PostModel(
      {this.id,
        this.content,
        this.image,
        this.createdAt,
        this.commentCount,
        this.likeCount,
        this.userId,
        this.user,
        this.likes,
      });

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    image = json['image'];
    createdAt = json['created_at'];
    commentCount = json['comment_count'];
    likeCount = json['like_count'];
    userId = json['user_id'];
    user = json['user'] != null ?  UserModel.fromJson(json['user']) : null;
    if(json["likes"] != null){
      likes=<LikesModel>[];
      json["likes"].forEach((v){
        likes!.add(LikesModel.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['comment_count'] = commentCount;
    data['like_count'] = likeCount;
    data['user_id'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

