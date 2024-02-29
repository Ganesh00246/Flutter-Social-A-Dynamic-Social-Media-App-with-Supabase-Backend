import 'package:clone/models/user_model.dart';

class ReplyModel {
  int? id;
  String? userId;
  int? postId;
  String? reply;
  String? createdAt;
  UserModel? user;

  ReplyModel(
      {this.id,
        this.userId,
        this.postId,
        this.reply,
        this.createdAt,
        this.user});

  ReplyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    reply = json['reply'];
    createdAt = json['created_at'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['post_id'] = postId;
    data['reply'] = reply;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}


