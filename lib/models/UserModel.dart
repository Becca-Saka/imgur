/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the UserModel type in your schema. */
@immutable
class UserModel extends Model {
  static const classType = const _UserModelModelType();
  final String id;
  final String? _username;
  final String? _email;
  final String? _picture;
  final List<Albums>? _albums;
  final List<PostComment>? _postComments;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get username {
    try {
      return _username!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get email {
    return _email;
  }
  
  String? get picture {
    return _picture;
  }
  
  List<Albums>? get albums {
    return _albums;
  }
  
  List<PostComment>? get postComments {
    return _postComments;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const UserModel._internal({required this.id, required username, email, picture, albums, postComments, createdAt, updatedAt}): _username = username, _email = email, _picture = picture, _albums = albums, _postComments = postComments, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory UserModel({String? id, required String username, String? email, String? picture, List<Albums>? albums, List<PostComment>? postComments}) {
    return UserModel._internal(
      id: id == null ? UUID.getUUID() : id,
      username: username,
      email: email,
      picture: picture,
      albums: albums != null ? List<Albums>.unmodifiable(albums) : albums,
      postComments: postComments != null ? List<PostComment>.unmodifiable(postComments) : postComments);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserModel &&
      id == other.id &&
      _username == other._username &&
      _email == other._email &&
      _picture == other._picture &&
      DeepCollectionEquality().equals(_albums, other._albums) &&
      DeepCollectionEquality().equals(_postComments, other._postComments);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserModel {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("picture=" + "$_picture" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserModel copyWith({String? id, String? username, String? email, String? picture, List<Albums>? albums, List<PostComment>? postComments}) {
    return UserModel._internal(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      picture: picture ?? this.picture,
      albums: albums ?? this.albums,
      postComments: postComments ?? this.postComments);
  }
  
  UserModel.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _username = json['username'],
      _email = json['email'],
      _picture = json['picture'],
      _albums = json['albums'] is List
        ? (json['albums'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Albums.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _postComments = json['postComments'] is List
        ? (json['postComments'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => PostComment.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'username': _username, 'email': _email, 'picture': _picture, 'albums': _albums?.map((Albums? e) => e?.toJson()).toList(), 'postComments': _postComments?.map((PostComment? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "userModel.id");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PICTURE = QueryField(fieldName: "picture");
  static final QueryField ALBUMS = QueryField(
    fieldName: "albums",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Albums).toString()));
  static final QueryField POSTCOMMENTS = QueryField(
    fieldName: "postComments",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (PostComment).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserModel";
    modelSchemaDefinition.pluralName = "UserModels";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserModel.USERNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserModel.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserModel.PICTURE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: UserModel.ALBUMS,
      isRequired: false,
      ofModelName: (Albums).toString(),
      associatedKey: Albums.USERMODELID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: UserModel.POSTCOMMENTS,
      isRequired: false,
      ofModelName: (PostComment).toString(),
      associatedKey: PostComment.USERMODELID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UserModelModelType extends ModelType<UserModel> {
  const _UserModelModelType();
  
  @override
  UserModel fromJson(Map<String, dynamic> jsonData) {
    return UserModel.fromJson(jsonData);
  }
}