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

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the PostComment type in your schema. */
@immutable
class PostComment extends Model {
  static const classType = const _PostCommentModelType();
  final String id;
  final String? _imgurId;
  final String? _comment;
  final String? _date;
  final String? _usermodelID;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get imgurId {
    try {
      return _imgurId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get comment {
    return _comment;
  }
  
  String? get date {
    return _date;
  }
  
  String get usermodelID {
    try {
      return _usermodelID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const PostComment._internal({required this.id, required imgurId, comment, date, required usermodelID, createdAt, updatedAt}): _imgurId = imgurId, _comment = comment, _date = date, _usermodelID = usermodelID, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory PostComment({String? id, required String imgurId, String? comment, String? date, required String usermodelID}) {
    return PostComment._internal(
      id: id == null ? UUID.getUUID() : id,
      imgurId: imgurId,
      comment: comment,
      date: date,
      usermodelID: usermodelID);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PostComment &&
      id == other.id &&
      _imgurId == other._imgurId &&
      _comment == other._comment &&
      _date == other._date &&
      _usermodelID == other._usermodelID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("PostComment {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("imgurId=" + "$_imgurId" + ", ");
    buffer.write("comment=" + "$_comment" + ", ");
    buffer.write("date=" + "$_date" + ", ");
    buffer.write("usermodelID=" + "$_usermodelID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  PostComment copyWith({String? id, String? imgurId, String? comment, String? date, String? usermodelID}) {
    return PostComment._internal(
      id: id ?? this.id,
      imgurId: imgurId ?? this.imgurId,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      usermodelID: usermodelID ?? this.usermodelID);
  }
  
  PostComment.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _imgurId = json['imgurId'],
      _comment = json['comment'],
      _date = json['date'],
      _usermodelID = json['usermodelID'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'imgurId': _imgurId, 'comment': _comment, 'date': _date, 'usermodelID': _usermodelID, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "postComment.id");
  static final QueryField IMGURID = QueryField(fieldName: "imgurId");
  static final QueryField COMMENT = QueryField(fieldName: "comment");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField USERMODELID = QueryField(fieldName: "usermodelID");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "PostComment";
    modelSchemaDefinition.pluralName = "PostComments";
    
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
      key: PostComment.IMGURID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostComment.COMMENT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostComment.DATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: PostComment.USERMODELID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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

class _PostCommentModelType extends ModelType<PostComment> {
  const _PostCommentModelType();
  
  @override
  PostComment fromJson(Map<String, dynamic> jsonData) {
    return PostComment.fromJson(jsonData);
  }
}