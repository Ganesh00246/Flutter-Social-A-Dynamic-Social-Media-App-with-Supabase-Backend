
class UserModel {
  String? email;
  String? id;
  String? createdAt;
  Metadata? metadata;

  UserModel({this.email, this.metadata,this.createdAt , this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    createdAt = json['created_at'];
    metadata = json['metadata'] != null
        ? Metadata.fromJson(json['metadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['email'] = email;
    data['id'] = id;
    data['created_at'] = createdAt;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    return data;
  }
}

class Metadata {
  String? name;
  String? image;
  String? description;

  Metadata({this.name, this.image, this.description});

  Metadata.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    return data;
  }
}