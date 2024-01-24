class NityaNiyamModel {
  NityaNiyamModel({
    this.isError,
    this.message,
    this.data,
  });

  NityaNiyamModel.fromJson(Map<String, dynamic> json)
      : isError = json['isError'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => NityaNiyamData.fromJson(e as Map<String, dynamic>)).toList();
  final bool? isError;
  final String? message;
  final List<NityaNiyamData>? data;

  Map<String, dynamic> toJson() => {'isError': isError, 'message': message, 'data': data?.map((e) => e.toJson()).toList()};
}

class NityaNiyamData {
  NityaNiyamData(
      {this.id,
      this.gujaratiNityaNiyam,
      this.englishNityaNiyam,
      this.oldId,
      this.category,
      this.gTag,
      this.siteAccess,
      this.newsShow,
      this.eventId,
      this.audioFile,
      this.videoId,
      this.author,
      this.feature,
      this.displayOrder,
      this.createdDate,
      this.createdBy,
      this.status,
      this.v,
      this.publishLocationName,
      this.publishLocationSlug,
      this.authorName,
      this.authorSlug});

  NityaNiyamData.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        gujaratiNityaNiyam = (json['gujaratiNityaNiyam'] as Map<String, dynamic>?) != null
            ? GujaratiNityaNiyam.fromJson(json['gujaratiNityaNiyam'] as Map<String, dynamic>)
            : null,
        englishNityaNiyam = (json['englishNityaNiyam'] as Map<String, dynamic>?) != null
            ? EnglishNityaNiyam.fromJson(json['englishNityaNiyam'] as Map<String, dynamic>)
            : null,
        oldId = json['old_id'] as String?,
        category = json['category'] as String?,
        gTag = json['g_tag'] as String?,
        siteAccess = json['siteAccess'] as String?,
        newsShow = json['news_show'] as String?,
        eventId = json['event_id'] as String?,
        audioFile = json['audio_file'] as String?,
        videoId = json['video_id'] as String?,
        author = json['author'] as String?,
        feature = json['feature'] as String?,
        displayOrder = json['displayOrder'] as int?,
        createdDate = json['createdDate'] as String?,
        createdBy = json['createdBy'] as String?,
        status = json['status'] as String?,
        v = json['__v'] as int?,
        publishLocationName = json['publishLocationName'] as List?,
        publishLocationSlug = json['publishLocationSlug'] as List?,
        authorName = json['authorName'] as List?,
        authorSlug = json['authorSlug'] as List?;
  final String? id;
  final GujaratiNityaNiyam? gujaratiNityaNiyam;
  final EnglishNityaNiyam? englishNityaNiyam;
  final String? oldId;
  final String? category;
  final String? gTag;
  final String? siteAccess;
  final String? newsShow;
  final String? eventId;
  final String? audioFile;
  final String? videoId;
  final String? author;
  final String? feature;
  final int? displayOrder;
  final String? createdDate;
  final String? createdBy;
  final String? status;
  final int? v;
  final List<dynamic>? publishLocationName;
  final List<dynamic>? publishLocationSlug;
  final List<dynamic>? authorName;
  final List<dynamic>? authorSlug;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'gujaratiNityaNiyam': gujaratiNityaNiyam?.toJson(),
        'englishNityaNiyam': englishNityaNiyam?.toJson(),
        'old_id': oldId,
        'category': category,
        'g_tag': gTag,
        'siteAccess': siteAccess,
        'news_show': newsShow,
        'event_id': eventId,
        'audio_file': audioFile,
        'video_id': videoId,
        'author': author,
        'feature': feature,
        'displayOrder': displayOrder,
        'createdDate': createdDate,
        'createdBy': createdBy,
        'status': status,
        '__v': v,
        'publishLocationName': publishLocationName,
        'publishLocationSlug': publishLocationSlug,
        'authorName': authorName,
        'authorSlug': authorSlug
      };
}

class GujaratiNityaNiyam {
  GujaratiNityaNiyam({
    this.title,
    this.desc,
    this.text,
  });

  GujaratiNityaNiyam.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?,
        desc = json['desc'] as String?,
        text = json['text'] as String?;
  final String? title;
  final String? desc;
  final String? text;

  Map<String, dynamic> toJson() => {'title': title, 'desc': desc, 'text': text};
}

class EnglishNityaNiyam {
  EnglishNityaNiyam({
    this.title,
    this.desc,
    this.text,
  });

  EnglishNityaNiyam.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?,
        desc = json['desc'] as String?,
        text = json['text'] as String?;
  final String? title;
  final String? desc;
  final String? text;

  Map<String, dynamic> toJson() => {'title': title, 'desc': desc, 'text': text};
}
