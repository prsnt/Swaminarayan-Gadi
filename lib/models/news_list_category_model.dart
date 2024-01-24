class NewsListCategoryModel {
  NewsListCategoryModel({
    this.isError,
    this.message,
    this.data,
  });

  NewsListCategoryModel.fromJson(Map<String, dynamic> json)
      : isError = json['isError'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String, dynamic>?) != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null;
  final bool? isError;
  final String? message;
  final Data? data;

  Map<String, dynamic> toJson() => {'isError': isError, 'message': message, 'data': data?.toJson()};
}

class Data {
  Data({
    this.total,
    this.perpage,
    this.currentpage,
    this.totalpages,
    this.nextpage,
    this.remainingCount,
    this.newsCategoryDataList,
  });

  Data.fromJson(Map<String, dynamic> json)
      : total = json['total'] as int?,
        perpage = json['perpage'] as int?,
        currentpage = json['currentpage'] as int?,
        totalpages = json['totalpages'] as int?,
        nextpage = json['nextpage'] as int?,
        remainingCount = json['remainingCount'] as int?,
        newsCategoryDataList = (json['data'] as List?)?.map((dynamic e) => NewsCategoryData.fromJson(e as Map<String, dynamic>)).toList();
  final int? total;
  final int? perpage;
  final int? currentpage;
  final int? totalpages;
  final int? nextpage;
  final int? remainingCount;
  final List<NewsCategoryData>? newsCategoryDataList;

  Map<String, dynamic> toJson() => {
        'total': total,
        'perpage': perpage,
        'currentpage': currentpage,
        'totalpages': totalpages,
        'nextpage': nextpage,
        'remainingCount': remainingCount,
        'data': newsCategoryDataList?.map((e) => e.toJson()).toList()
      };
}

class NewsCategoryData {
  NewsCategoryData({
    this.id,
    this.name,
    this.oldId,
    this.slug,
    this.feature,
    this.parentId,
    this.displayOrder,
    this.createdDate,
    this.createdBy,
    this.status,
    this.v,
  });

  NewsCategoryData.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        name = json['name'] as String?,
        oldId = json['old_id'] as String?,
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
  final String? oldId;
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
        'old_id': oldId,
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
