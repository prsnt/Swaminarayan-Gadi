class NewsImageGallaryModel {
  NewsImageGallaryModel({
    this.isError,
    this.message,
    this.newsImageGallaryData,
  });

  NewsImageGallaryModel.fromJson(Map<String, dynamic> json)
      : isError = json['isError'] as bool?,
        message = json['message'] as String?,
        newsImageGallaryData = (json['data'] as List?)?.map((dynamic e) => NewsImageGallaryData.fromJson(e as Map<String, dynamic>)).toList();
  final bool? isError;
  final String? message;
  final List<NewsImageGallaryData>? newsImageGallaryData;

  Map<String, dynamic> toJson() => {'isError': isError, 'message': message, 'data': newsImageGallaryData?.map((e) => e.toJson()).toList()};
}

class NewsImageGallaryData {
  NewsImageGallaryData({
    this.id,
    this.siteAccess,
    this.name,
    this.slug,
    this.oldId,
    this.newsGallaryImageJson,
    this.url,
    this.keywords,
    this.feature,
    this.displayOrder,
    this.createdDate,
    this.createdBy,
    this.status,
    this.v,
  });

  NewsImageGallaryData.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        siteAccess = json['siteAccess'] as String?,
        name = json['name'] as String?,
        slug = json['slug'] as String?,
        oldId = json['old_id'] as String?,
        newsGallaryImageJson = (json['image_json'] as List?)?.map((dynamic e) => NewsGallaryImageJson.fromJson(e as Map<String, dynamic>)).toList(),
        url = json['url'] as String?,
        keywords = json['keywords'] as String?,
        feature = json['feature'] as String?,
        displayOrder = json['displayOrder'] as int?,
        createdDate = json['createdDate'] as String?,
        createdBy = json['createdBy'] as String?,
        status = json['status'] as String?,
        v = json['__v'] as int?;
  final String? id;
  final String? siteAccess;
  final String? name;
  final String? slug;
  final String? oldId;
  final List<NewsGallaryImageJson>? newsGallaryImageJson;
  final String? url;
  final String? keywords;
  final String? feature;
  final int? displayOrder;
  final String? createdDate;
  final String? createdBy;
  final String? status;
  final int? v;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'siteAccess': siteAccess,
        'name': name,
        'slug': slug,
        'old_id': oldId,
        'image_json': newsGallaryImageJson?.map((e) => e.toJson()).toList(),
        'url': url,
        'keywords': keywords,
        'feature': feature,
        'displayOrder': displayOrder,
        'createdDate': createdDate,
        'createdBy': createdBy,
        'status': status,
        '__v': v
      };
}

class NewsGallaryImageJson {
  NewsGallaryImageJson({
    this.imgName,
    this.imgRename,
    this.oldFolder,
    this.oldId,
    this.position,
    this.lastModified,
    this.lastModifiedDate,
    this.image,
    this.imageAlt,
    this.caption,
    this.status,
    this.imageFeature,
    this.imageurl,
  });

  NewsGallaryImageJson.fromJson(Map<String, dynamic> json)
      : imgName = json['img_name'] as String?,
        imgRename = json['img_rename'] as String?,
        oldFolder = json['old_folder'] as String?,
        oldId = json['old_id'] as String?,
        position = json['position'] as String?,
        lastModified = json['lastModified'] as String?,
        lastModifiedDate = json['lastModifiedDate'] as String?,
        image = json['image'] as String?,
        imageAlt = json['image_alt'] as String?,
        caption = json['caption'] as String?,
        status = json['status'] as String?,
        imageFeature = json['image_feature'] as String?,
        imageurl = json['imageurl'] as String?;
  final String? imgName;
  final String? imgRename;
  final String? oldFolder;
  final String? oldId;
  final String? position;
  final String? lastModified;
  final String? lastModifiedDate;
  final String? image;
  final String? imageAlt;
  final String? caption;
  final String? status;
  final String? imageFeature;
  final String? imageurl;

  Map<String, dynamic> toJson() => {
        'img_name': imgName,
        'img_rename': imgRename,
        'old_folder': oldFolder,
        'old_id': oldId,
        'position': position,
        'lastModified': lastModified,
        'lastModifiedDate': lastModifiedDate,
        'image': image,
        'image_alt': imageAlt,
        'caption': caption,
        'status': status,
        'image_feature': imageFeature,
        'imageurl': imageurl
      };
}
