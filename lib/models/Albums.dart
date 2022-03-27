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


/** This is an auto generated class representing the Albums type in your schema. */
@immutable
class Albums extends Model {
  static const classType = const _AlbumsModelType();
  final String id;
  final String? _imgureId;
  final String? _imgurAlbumLink;
  final String? _coverLink;
  final String? _coverType;
  final int? _length;
  final String? _title;
  final int? _dateTime;
  final String? _usermodelID;
  final bool? _isFavourite;
  final int? _points;
  final int? _coverHeight;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get imgureId {
    try {
      return _imgureId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get imgurAlbumLink {
    try {
      return _imgurAlbumLink!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get coverLink {
    try {
      return _coverLink!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get coverType {
    try {
      return _coverType!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get length {
    try {
      return _length!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get title {
    try {
      return _title!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int? get dateTime {
    return _dateTime;
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
  
  bool? get isFavourite {
    return _isFavourite;
  }
  
  int? get points {
    return _points;
  }
  
  int? get coverHeight {
    return _coverHeight;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Albums._internal({required this.id, required imgureId, required imgurAlbumLink, required coverLink, required coverType, required length, required title, dateTime, required usermodelID, isFavourite, points, coverHeight, createdAt, updatedAt}): _imgureId = imgureId, _imgurAlbumLink = imgurAlbumLink, _coverLink = coverLink, _coverType = coverType, _length = length, _title = title, _dateTime = dateTime, _usermodelID = usermodelID, _isFavourite = isFavourite, _points = points, _coverHeight = coverHeight, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Albums({String? id, required String imgureId, required String imgurAlbumLink, required String coverLink, required String coverType, required int length, required String title, int? dateTime, required String usermodelID, bool? isFavourite, int? points, int? coverHeight}) {
    return Albums._internal(
      id: id == null ? UUID.getUUID() : id,
      imgureId: imgureId,
      imgurAlbumLink: imgurAlbumLink,
      coverLink: coverLink,
      coverType: coverType,
      length: length,
      title: title,
      dateTime: dateTime,
      usermodelID: usermodelID,
      isFavourite: isFavourite,
      points: points,
      coverHeight: coverHeight);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Albums &&
      id == other.id &&
      _imgureId == other._imgureId &&
      _imgurAlbumLink == other._imgurAlbumLink &&
      _coverLink == other._coverLink &&
      _coverType == other._coverType &&
      _length == other._length &&
      _title == other._title &&
      _dateTime == other._dateTime &&
      _usermodelID == other._usermodelID &&
      _isFavourite == other._isFavourite &&
      _points == other._points &&
      _coverHeight == other._coverHeight;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Albums {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("imgureId=" + "$_imgureId" + ", ");
    buffer.write("imgurAlbumLink=" + "$_imgurAlbumLink" + ", ");
    buffer.write("coverLink=" + "$_coverLink" + ", ");
    buffer.write("coverType=" + "$_coverType" + ", ");
    buffer.write("length=" + (_length != null ? _length!.toString() : "null") + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("dateTime=" + (_dateTime != null ? _dateTime!.toString() : "null") + ", ");
    buffer.write("usermodelID=" + "$_usermodelID" + ", ");
    buffer.write("isFavourite=" + (_isFavourite != null ? _isFavourite!.toString() : "null") + ", ");
    buffer.write("points=" + (_points != null ? _points!.toString() : "null") + ", ");
    buffer.write("coverHeight=" + (_coverHeight != null ? _coverHeight!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Albums copyWith({String? id, String? imgureId, String? imgurAlbumLink, String? coverLink, String? coverType, int? length, String? title, int? dateTime, String? usermodelID, bool? isFavourite, int? points, int? coverHeight}) {
    return Albums._internal(
      id: id ?? this.id,
      imgureId: imgureId ?? this.imgureId,
      imgurAlbumLink: imgurAlbumLink ?? this.imgurAlbumLink,
      coverLink: coverLink ?? this.coverLink,
      coverType: coverType ?? this.coverType,
      length: length ?? this.length,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      usermodelID: usermodelID ?? this.usermodelID,
      isFavourite: isFavourite ?? this.isFavourite,
      points: points ?? this.points,
      coverHeight: coverHeight ?? this.coverHeight);
  }
  
  Albums.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _imgureId = json['imgureId'],
      _imgurAlbumLink = json['imgurAlbumLink'],
      _coverLink = json['coverLink'],
      _coverType = json['coverType'],
      _length = (json['length'] as num?)?.toInt(),
      _title = json['title'],
      _dateTime = (json['dateTime'] as num?)?.toInt(),
      _usermodelID = json['usermodelID'],
      _isFavourite = json['isFavourite'],
      _points = (json['points'] as num?)?.toInt(),
      _coverHeight = (json['coverHeight'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'imgureId': _imgureId, 'imgurAlbumLink': _imgurAlbumLink, 'coverLink': _coverLink, 'coverType': _coverType, 'length': _length, 'title': _title, 'dateTime': _dateTime, 'usermodelID': _usermodelID, 'isFavourite': _isFavourite, 'points': _points, 'coverHeight': _coverHeight, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "albums.id");
  static final QueryField IMGUREID = QueryField(fieldName: "imgureId");
  static final QueryField IMGURALBUMLINK = QueryField(fieldName: "imgurAlbumLink");
  static final QueryField COVERLINK = QueryField(fieldName: "coverLink");
  static final QueryField COVERTYPE = QueryField(fieldName: "coverType");
  static final QueryField LENGTH = QueryField(fieldName: "length");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField DATETIME = QueryField(fieldName: "dateTime");
  static final QueryField USERMODELID = QueryField(fieldName: "usermodelID");
  static final QueryField ISFAVOURITE = QueryField(fieldName: "isFavourite");
  static final QueryField POINTS = QueryField(fieldName: "points");
  static final QueryField COVERHEIGHT = QueryField(fieldName: "coverHeight");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Albums";
    modelSchemaDefinition.pluralName = "Albums";
    
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
      key: Albums.IMGUREID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Albums.IMGURALBUMLINK,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Albums.COVERLINK,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Albums.COVERTYPE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Albums.LENGTH,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Albums.TITLE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Albums.DATETIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Albums.USERMODELID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Albums.ISFAVOURITE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Albums.POINTS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Albums.COVERHEIGHT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
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

class _AlbumsModelType extends ModelType<Albums> {
  const _AlbumsModelType();
  
  @override
  Albums fromJson(Map<String, dynamic> jsonData) {
    return Albums.fromJson(jsonData);
  }
}