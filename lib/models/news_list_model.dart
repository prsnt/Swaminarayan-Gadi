class NewsListModel {
  NewsListModel({
    this.isError,
    this.message,
    this.mainData,
  });

  NewsListModel.fromJson(Map<String, dynamic> json)
      : isError = json['isError'] as bool?,
        message = json['message'] as String?,
        mainData = (json['data'] as Map<String, dynamic>?) != null ? MainData.fromJson(json['data'] as Map<String, dynamic>) : null;
  final bool? isError;
  final String? message;
  final MainData? mainData;

  Map<String, dynamic> toJson() => {'isError': isError, 'message': message, 'data': mainData?.toJson()};
}

class MainData {
  MainData({
    this.total,
    this.perpage,
    this.currentpage,
    this.totalpages,
    this.nextpage,
    this.remainingCount,
    this.data,
  });

  MainData.fromJson(Map<String, dynamic> json)
      : total = json['total'] as int?,
        perpage = json['perpage'] as int?,
        currentpage = json['currentpage'] as int?,
        totalpages = json['totalpages'] as int?,
        nextpage = json['nextpage'] as int?,
        remainingCount = json['remainingCount'] as int?,
        data = (json['data'] as List?)?.map((dynamic e) => NewsData.fromJson(e as Map<String, dynamic>)).toList();
  final int? total;
  final int? perpage;
  final int? currentpage;
  final int? totalpages;
  final int? nextpage;
  final int? remainingCount;
  final List<NewsData>? data;

  Map<String, dynamic> toJson() => {
        'total': total,
        'perpage': perpage,
        'currentpage': currentpage,
        'totalpages': totalpages,
        'nextpage': nextpage,
        'remainingCount': remainingCount,
        'data': data?.map((e) => e.toJson()).toList()
      };
}

class NewsData {
  NewsData({
    this.id,
    this.title,
    this.slug,
    this.oldId,
    this.oldPageId,
    this.oldArticleurl,
    this.category,
    this.gTag,
    this.siteAccess,
    this.eventId,
    this.tagline,
    this.header,
    this.desc,
    this.image,
    this.imageAlt,
    this.uploadLocation,
    this.reference,
    this.referenceLink,
    this.publishOn,
    this.publishOnGujCalendar,
    this.publishLocation,
    this.metaTitle,
    this.metaDescription,
    this.feature,
    this.displayOrder,
    this.createdDate,
    this.createdBy,
    this.status,
    this.showOnMainSite,
    this.pushNotification,
    this.v,
    this.updatedBy,
    this.updatedDate,
    this.imageThumb,
    this.publishLocationName,
    this.publishLocationSlug,
  });

  NewsData.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        title = json['title'] as String?,
        slug = json['slug'] as String?,
        oldId = json['old_id'] as String?,
        oldPageId = json['old_page_id'] as String?,
        oldArticleurl = json['old_articleurl'] as String?,
        category = json['category'] as String?,
        gTag = json['g_tag'] as String?,
        siteAccess = json['siteAccess'] as String?,
        eventId = json['event_id'] as String?,
        tagline = json['tagline'] as String?,
        header = json['header'] as String?,
        desc = json['desc'] as String?,
        image = json['image'] as String?,
        imageAlt = json['image_alt'] as String?,
        uploadLocation = json['upload_location'] as String?,
        reference = json['reference'] as String?,
        referenceLink = json['referenceLink'] as String?,
        publishOn = json['publishOn'] as String?,
        publishOnGujCalendar = json['publishOnGujCalendar'] as String?,
        publishLocation = json['publishLocation'] as String?,
        metaTitle = json['metaTitle'] as String?,
        metaDescription = json['metaDescription'] as String?,
        feature = json['feature'] as String?,
        displayOrder = json['displayOrder'] as int?,
        createdDate = json['createdDate'] as String?,
        createdBy = json['createdBy'] as String?,
        status = json['status'] as String?,
        showOnMainSite = json['showOnMainSite'] as String?,
        pushNotification = json['pushNotification'] as String?,
        v = json['__v'] as int?,
        updatedBy = json['updatedBy'] as String?,
        updatedDate = json['updatedDate'] as String?,
        imageThumb = json['image_Thumb'] as String?,
        publishLocationName = json['publishLocationName'] as List?,
        publishLocationSlug = json['publishLocationSlug'] as List?;
  final String? id;
  final String? title;
  final String? slug;
  final String? oldId;
  final String? oldPageId;
  final String? oldArticleurl;
  final String? category;
  final String? gTag;
  final String? siteAccess;
  final String? eventId;
  final String? tagline;
  final String? header;
  final String? desc;
  final String? image;
  final String? imageAlt;
  final String? uploadLocation;
  final String? reference;
  final String? referenceLink;
  final String? publishOn;
  final String? publishOnGujCalendar;
  final String? publishLocation;
  final String? metaTitle;
  final String? metaDescription;
  final String? feature;
  final int? displayOrder;
  final String? createdDate;
  final String? createdBy;
  final String? status;
  final String? showOnMainSite;
  final String? pushNotification;
  final int? v;
  final String? updatedBy;
  final String? updatedDate;
  final String? imageThumb;
  final List<dynamic>? publishLocationName;
  final List<dynamic>? publishLocationSlug;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'slug': slug,
        'old_id': oldId,
        'old_page_id': oldPageId,
        'old_articleurl': oldArticleurl,
        'category': category,
        'g_tag': gTag,
        'siteAccess': siteAccess,
        'event_id': eventId,
        'tagline': tagline,
        'header': header,
        'desc': desc,
        'image': image,
        'image_alt': imageAlt,
        'upload_location': uploadLocation,
        'reference': reference,
        'referenceLink': referenceLink,
        'publishOn': publishOn,
        'publishOnGujCalendar': publishOnGujCalendar,
        'publishLocation': publishLocation,
        'metaTitle': metaTitle,
        'metaDescription': metaDescription,
        'feature': feature,
        'displayOrder': displayOrder,
        'createdDate': createdDate,
        'createdBy': createdBy,
        'status': status,
        'showOnMainSite': showOnMainSite,
        'pushNotification': pushNotification,
        '__v': v,
        'updatedBy': updatedBy,
        'updatedDate': updatedDate,
        'image_Thumb': imageThumb,
        'publishLocationName': publishLocationName,
        'publishLocationSlug': publishLocationSlug
      };
}

// class CategoryName {
//   final String? 62e0cf26bd4256f61830d330;
//
//   CategoryName({
//   this.62e0cf26bd4256f61830d330,
//   });
//
//   CategoryName.fromJson(Map<String, dynamic> json)
//       : 62e0cf26bd4256f61830d330 = json['62e0cf26bd4256f61830d330'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     '62e0cf26bd4256f61830d330' : 62e0cf26bd4256f61830d330
//   };
// }
//
// class CategorySlug {
//   final String? 62e0cf26bd4256f61830d330;
//
//   CategorySlug({
//   this.62e0cf26bd4256f61830d330,
//   });
//
//   CategorySlug.fromJson(Map<String, dynamic> json)
//       : 62e0cf26bd4256f61830d330 = json['62e0cf26bd4256f61830d330'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     '62e0cf26bd4256f61830d330' : 62e0cf26bd4256f61830d330
//   };
// }
//
// class GTagName {
//   final String? 62cdb95aed7932f21fc1346e;
//
//   GTagName({
//   this.62cdb95aed7932f21fc1346e,
//   });
//
//   GTagName.fromJson(Map<String, dynamic> json)
//       : 62cdb95aed7932f21fc1346e = json['62cdb95aed7932f21fc1346e'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     '62cdb95aed7932f21fc1346e' : 62cdb95aed7932f21fc1346e
//   };
// }
//
// class GTagSlug {
//   final String? 62cdb95aed7932f21fc1346e;
//
//   GTagSlug({
//   this.62cdb95aed7932f21fc1346e,
//   });
//
//   GTagSlug.fromJson(Map<String, dynamic> json)
//       : 62cdb95aed7932f21fc1346e = json['62cdb95aed7932f21fc1346e'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     '62cdb95aed7932f21fc1346e' : 62cdb95aed7932f21fc1346e
//   };
//}
