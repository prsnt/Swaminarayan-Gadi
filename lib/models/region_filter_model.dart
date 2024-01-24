class RegionFilterModel {
  RegionFilterModel({
    this.isError,
    this.message,
    this.data,
  });

  RegionFilterModel.fromJson(Map<String, dynamic> json)
      : isError = json['isError'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => RegionData.fromJson(e as Map<String, dynamic>)).toList();
  final bool? isError;
  final String? message;
  final List<RegionData>? data;

  Map<String, dynamic> toJson() => {'isError': isError, 'message': message, 'data': data?.map((e) => e.toJson()).toList()};
}

class RegionData {
  RegionData({
    this.id,
    this.name,
    this.slug,
    this.feature,
    this.displayOrder,
    this.createdDate,
    this.createdBy,
    this.status,
    this.v,
    this.deleted,
    this.updatedBy,
    this.updatedDate,
  });

  RegionData.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        name = json['name'] as String?,
        slug = json['slug'] as String?,
        feature = json['feature'] as String?,
        displayOrder = json['displayOrder'] as int?,
        createdDate = json['createdDate'] as String?,
        createdBy = json['createdBy'] as String?,
        status = json['status'] as String?,
        v = json['__v'] as int?,
        deleted = json['deleted'] as String?,
        updatedBy = json['updatedBy'] as String?,
        updatedDate = json['updatedDate'] as String?;
  final String? id;
  final String? name;
  final String? slug;
  final String? feature;
  final int? displayOrder;
  final String? createdDate;
  final String? createdBy;
  final String? status;
  final int? v;
  final String? deleted;
  final String? updatedBy;
  final String? updatedDate;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'slug': slug,
        'feature': feature,
        'displayOrder': displayOrder,
        'createdDate': createdDate,
        'createdBy': createdBy,
        'status': status,
        '__v': v,
        'deleted': deleted,
        'updatedBy': updatedBy,
        'updatedDate': updatedDate
      };
}
