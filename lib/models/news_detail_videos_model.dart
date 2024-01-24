class NewsDetailVideosModel {
  NewsDetailVideosModel({
    this.isError,
    this.message,
    this.newsDetailVideosDataList,
  });

  NewsDetailVideosModel.fromJson(Map<String, dynamic> json)
      : isError = json['isError'] as bool?,
        message = json['message'] as String?,
        newsDetailVideosDataList = (json['data'] as List?)?.map((dynamic e) => NewsDetailVideosData.fromJson(e as Map<String, dynamic>)).toList();
  final bool? isError;
  final String? message;
  final List<NewsDetailVideosData>? newsDetailVideosDataList;

  Map<String, dynamic> toJson() => {'isError': isError, 'message': message, 'data': newsDetailVideosDataList?.map((e) => e.toJson()).toList()};
}

class NewsDetailVideosData {
  NewsDetailVideosData({
    this.id,
    this.title,
    this.slug,
    this.oldId,
    this.category,
    this.album,
    this.gTag,
    this.siteAccess,
    this.newsShow,
    this.eventId,
    this.tagline,
    this.desc,
    this.videoLength,
    this.videoFile,
    this.videoUrl,
    this.liveProvider,
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
    this.publishLocationName,
    this.publishLocationSlug,
    this.artistName,
    this.artistSlug,
    this.artistTypeName,
    this.artistTypeSlug,
  });

  NewsDetailVideosData.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        title = json['title'] as String?,
        slug = json['slug'] as String?,
        oldId = json['old_id'] as String?,
        category = json['category'] as String?,
        album = json['album'] as String?,
        gTag = json['g_tag'] as String?,
        siteAccess = json['siteAccess'] as String?,
        newsShow = json['news_show'] as String?,
        eventId = json['event_id'] as String?,
        tagline = json['tagline'] as String?,
        desc = json['desc'] as String?,
        videoLength = json['video_length'] as String?,
        videoFile = json['video_file'] as String?,
        videoUrl = json['video_url'] as String?,
        liveProvider = json['live_provider'] as String?,
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
        publishLocationName = json['publishLocationName'] as List?,
        publishLocationSlug = json['publishLocationSlug'] as List?,
        artistName = json['artistName'] as List?,
        artistSlug = json['artistSlug'] as List?,
        artistTypeName = json['artistTypeName'] as List?,
        artistTypeSlug = json['artistTypeSlug'] as List?;
  final String? id;
  final String? title;
  final String? slug;
  final String? oldId;
  final String? category;
  final String? album;
  final String? gTag;
  final String? siteAccess;
  final String? newsShow;
  final String? eventId;
  final String? tagline;
  final String? desc;
  final String? videoLength;
  final String? videoFile;
  final String? videoUrl;
  final String? liveProvider;
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
  final List<dynamic>? publishLocationName;
  final List<dynamic>? publishLocationSlug;
  final List<dynamic>? artistName;
  final List<dynamic>? artistSlug;
  final List<dynamic>? artistTypeName;
  final List<dynamic>? artistTypeSlug;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'slug': slug,
        'old_id': oldId,
        'category': category,
        'album': album,
        'g_tag': gTag,
        'siteAccess': siteAccess,
        'news_show': newsShow,
        'event_id': eventId,
        'tagline': tagline,
        'desc': desc,
        'video_length': videoLength,
        'video_file': videoFile,
        'video_url': videoUrl,
        'live_provider': liveProvider,
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
        'publishLocationName': publishLocationName,
        'publishLocationSlug': publishLocationSlug,
        'artistName': artistName,
        'artistSlug': artistSlug,
        'artistTypeName': artistTypeName,
        'artistTypeSlug': artistTypeSlug
      };
}
