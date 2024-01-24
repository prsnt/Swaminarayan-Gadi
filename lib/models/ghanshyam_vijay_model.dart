class GhanshyamVijayModel {
  GhanshyamVijayModel({
    this.isError,
    this.message,
    this.mainData,
  });

  GhanshyamVijayModel.fromJson(Map<String, dynamic> json)
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
        data = (json['data'] as List?)?.map((dynamic e) => GhanshyamVijayData.fromJson(e as Map<String, dynamic>)).toList();
  final int? total;
  final int? perpage;
  final int? currentpage;
  final int? totalpages;
  final int? nextpage;
  final int? remainingCount;
  final List<GhanshyamVijayData>? data;

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

class GhanshyamVijayData {
  GhanshyamVijayData({
    this.id,
    this.title,
    this.slug,
    this.category,
    this.gTag,
    this.siteAccess,
    this.newsShow,
    this.eventId,
    this.tagline,
    this.desc,
    this.pdfFile,
    this.bannerImage,
    this.bannerImageAlt,
    this.uploadLocation,
    this.language,
    this.author,
    this.publishOn,
    this.publishOnGujCalendar,
    this.publishLocation,
    this.feature,
    this.metaTitle,
    this.metaDescription,
    this.displayOrder,
    this.createdDate,
    this.createdBy,
    this.status,
    this.v,
    this.pdfFileThumb,
    this.bannerImageThumb,
    // this.categoryName,
    // this.categorySlug,
    // this.gTagName,
    // this.gTagSlug,
    this.publishLocationName,
    this.publishLocationSlug,
    this.artistName,
    this.artistSlug,
    this.artistTypeName,
    this.artistTypeSlug,
    this.languageName,
    this.languageSlug,
  });

  GhanshyamVijayData.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        title = json['title'] as String?,
        slug = json['slug'] as String?,
        category = json['category'] as String?,
        gTag = json['g_tag'] as String?,
        siteAccess = json['siteAccess'] as String?,
        newsShow = json['news_show'] as String?,
        eventId = json['event_id'] as String?,
        tagline = json['tagline'] as String?,
        desc = json['desc'] as String?,
        pdfFile = json['pdf_file'] as String?,
        bannerImage = json['banner_image'] as String?,
        bannerImageAlt = json['banner_image_alt'] as String?,
        uploadLocation = json['upload_location'] as String?,
        language = json['language'] as String?,
        author = json['author'] as String?,
        publishOn = json['publishOn'] as String?,
        publishOnGujCalendar = json['publishOnGujCalendar'] as String?,
        publishLocation = json['publishLocation'] as String?,
        feature = json['feature'] as String?,
        metaTitle = json['metaTitle'] as String?,
        metaDescription = json['metaDescription'] as String?,
        displayOrder = json['displayOrder'] as int?,
        createdDate = json['createdDate'] as String?,
        createdBy = json['createdBy'] as String?,
        status = json['status'] as String?,
        v = json['__v'] as int?,
        pdfFileThumb = json['pdf_file_Thumb'] as String?,
        bannerImageThumb = json['banner_image_Thumb'] as String?,
        // categoryName = (json['categoryName'] as List?)?.map((dynamic e) => CategoryName.fromJson(e as Map<String,dynamic>)).toList(),
        // categorySlug = (json['categorySlug'] as List?)?.map((dynamic e) => CategorySlug.fromJson(e as Map<String,dynamic>)).toList(),
        // gTagName = (json['g_tagName'] as List?)?.map((dynamic e) => GTagName.fromJson(e as Map<String,dynamic>)).toList(),
        // gTagSlug = (json['g_tagSlug'] as List?)?.map((dynamic e) => GTagSlug.fromJson(e as Map<String,dynamic>)).toList(),
        publishLocationName = json['publishLocationName'] as List?,
        publishLocationSlug = json['publishLocationSlug'] as List?,
        artistName = json['artistName'] as List?,
        artistSlug = json['artistSlug'] as List?,
        artistTypeName = json['artistTypeName'] as List?,
        artistTypeSlug = json['artistTypeSlug'] as List?,
        languageName = json['languageName'] as List?,
        languageSlug = json['languageSlug'] as List?;
  final String? id;
  final String? title;
  final String? slug;
  final String? category;
  final String? gTag;
  final String? siteAccess;
  final String? newsShow;
  final String? eventId;
  final String? tagline;
  final String? desc;
  final String? pdfFile;
  final String? bannerImage;
  final String? bannerImageAlt;
  final String? uploadLocation;
  final String? language;
  final String? author;
  final String? publishOn;
  final String? publishOnGujCalendar;
  final String? publishLocation;
  final String? feature;
  final String? metaTitle;
  final String? metaDescription;
  final int? displayOrder;
  final String? createdDate;
  final String? createdBy;
  final String? status;
  final int? v;
  final String? pdfFileThumb;
  final String? bannerImageThumb;
  // final List<CategoryName>? categoryName;
  // final List<CategorySlug>? categorySlug;
  // final List<GTagName>? gTagName;
  // final List<GTagSlug>? gTagSlug;
  final List<dynamic>? publishLocationName;
  final List<dynamic>? publishLocationSlug;
  final List<dynamic>? artistName;
  final List<dynamic>? artistSlug;
  final List<dynamic>? artistTypeName;
  final List<dynamic>? artistTypeSlug;
  final List<dynamic>? languageName;
  final List<dynamic>? languageSlug;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'slug': slug,
        'category': category,
        'g_tag': gTag,
        'siteAccess': siteAccess,
        'news_show': newsShow,
        'event_id': eventId,
        'tagline': tagline,
        'desc': desc,
        'pdf_file': pdfFile,
        'banner_image': bannerImage,
        'banner_image_alt': bannerImageAlt,
        'upload_location': uploadLocation,
        'language': language,
        'author': author,
        'publishOn': publishOn,
        'publishOnGujCalendar': publishOnGujCalendar,
        'publishLocation': publishLocation,
        'feature': feature,
        'metaTitle': metaTitle,
        'metaDescription': metaDescription,
        'displayOrder': displayOrder,
        'createdDate': createdDate,
        'createdBy': createdBy,
        'status': status,
        '__v': v,
        'pdf_file_Thumb': pdfFileThumb,
        'banner_image_Thumb': bannerImageThumb,
        // 'categoryName' : categoryName?.map((e) => e.toJson()).toList(),
        // 'categorySlug' : categorySlug?.map((e) => e.toJson()).toList(),
        // 'g_tagName' : gTagName?.map((e) => e.toJson()).toList(),
        // 'g_tagSlug' : gTagSlug?.map((e) => e.toJson()).toList(),
        'publishLocationName': publishLocationName,
        'publishLocationSlug': publishLocationSlug,
        'artistName': artistName,
        'artistSlug': artistSlug,
        'artistTypeName': artistTypeName,
        'artistTypeSlug': artistTypeSlug,
        'languageName': languageName,
        'languageSlug': languageSlug
      };
}

// class CategoryName {
//   final String? 62ef62bbaf785ad273153add;
//
//   CategoryName({
//   this.62ef62bbaf785ad273153add,
//   });
//
//   CategoryName.fromJson(Map<String, dynamic> json)
//       : 62ef62bbaf785ad273153add = json['62ef62bbaf785ad273153add'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     '62ef62bbaf785ad273153add' : 62ef62bbaf785ad273153add
//   };
// }
//
// class CategorySlug {
//   final String? 62ef62bbaf785ad273153add;
//
//   CategorySlug({
//   this.62ef62bbaf785ad273153add,
//   });
//
//   CategorySlug.fromJson(Map<String, dynamic> json)
//       : 62ef62bbaf785ad273153add = json['62ef62bbaf785ad273153add'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     '62ef62bbaf785ad273153add' : 62ef62bbaf785ad273153add
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
// }
