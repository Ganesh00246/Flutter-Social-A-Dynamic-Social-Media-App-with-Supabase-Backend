import 'package:clone/models/user_model.dart';

class NotificationModel {
  int? id;
  int? postId;
  String? notification;
  String? createdAt;
  String? userId;
  UserModel? user;

  NotificationModel(
      {this.id,
        this.postId,
        this.notification,
        this.createdAt,
        this.userId,
        this.user,});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    notification = json['notification'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['post_id'] = postId;
    data['notification'] = notification;
    data['created_at'] = createdAt;
    data['user_id'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}


