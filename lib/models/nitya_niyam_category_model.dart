class NityaNiyamCategoryModel {
  NityaNiyamCategoryModel({
    this.isError,
    this.message,
    this.data,
  });

  NityaNiyamCategoryModel.fromJson(Map<String, dynamic> json)
      : isError = json['isError'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>)).toList();
  final bool? isError;
  final String? message;
  final List<Data>? data;

  Map<String, dynamic> toJson() => {'isError': isError, 'message': message, 'data': data?.map((e) => e.toJson()).toList()};
}

class Data {
  Data({
    this.id,
    this.name,
    this.slug,
    this.feature,
    this.parentId,
    this.displayOrder,
    this.createdDate,
    this.createdBy,
    this.status,
    this.v,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        name = json['name'] as String?,
        slug = json['slug'] as String?,
        feature = json['feature'] as String?,
        parentId = json['parent_id'] as String?,
        displayOrder = json['displayOrder'] as int?,
        createdDate = json['createdDate'] as String?,
        createdBy = json['createdBy'] as String?,
        status = json['status'] as String?,
        v = json['__v'] as int?;
  final String? id;
  final String? name;
  final String? slug;
  final String? feature;
  final String? parentId;
  final int? displayOrder;
  final String? createdDate;
  final String? createdBy;
  final String? status;
  final int? v;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'slug': slug,
        'feature': feature,
        'parent_id': parentId,
        'displayOrder': displayOrder,
        'createdDate': createdDate,
        'createdBy': createdBy,
        'status': status,
        '__v': v
      };
}
