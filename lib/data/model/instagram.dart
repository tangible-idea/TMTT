
import 'package:json_annotation/json_annotation.dart';

part 'instagram.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Instagram {

  Graphql? graphql = Graphql();

  Instagram({
    this.graphql,
  });

  factory Instagram.fromJson(Map<String, dynamic> json) => _$InstagramFromJson(json);
  Map<String, dynamic> toJson() => _$InstagramToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Graphql {
  InstagramUser? user = InstagramUser();
  Graphql({
    this.user,
  });
  factory Graphql.fromJson(Map<String, dynamic> json) => _$GraphqlFromJson(json);
  Map<String, dynamic> toJson() => _$GraphqlToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class InstagramUser {

  String biography ='';
  String profilePicUrl = ''; // 작은 해상도
  String profilePicUrlHd = ''; // 조금 더 큰 해상도
  String fullName = '';
  String username = '';

  InstagramUser({
    this.biography = '',
    this.profilePicUrl = '',
    this.profilePicUrlHd = '',
    this.fullName = '',
    this.username = '',
  });

  factory InstagramUser.fromJson(Map<String, dynamic> json) => _$InstagramUserFromJson(json);
  Map<String, dynamic> toJson() => _$InstagramUserToJson(this);
}


