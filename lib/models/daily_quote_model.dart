class DailyQuoteModel {
  DailyQuoteModel({
    this.isError,
    this.message,
    this.mainData,
  });

  DailyQuoteModel.fromJson(Map<String, dynamic> json)
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
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>)).toList();
  final int? total;
  final int? perpage;
  final int? currentpage;
  final int? totalpages;
  final int? nextpage;
  final int? remainingCount;
  final List<Data>? data;

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

class Data {
  Data({
    this.id,
    this.desc,
    this.gTag,
    this.oldId,
    this.author,
    this.displayOrder,
    this.createdDate,
    this.createdBy,
    this.status,
    this.v,
    this.publishLocationName,
    this.publishLocationSlug,
    this.authorName,
    this.authorSlug,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        desc = json['desc'] as String?,
        gTag = json['g_tag'] as String?,
        oldId = json['old_id'] as String?,
        author = json['author'] as String?,
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
  final String? desc;
  final String? gTag;
  final String? oldId;
  final String? author;
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
        'desc': desc,
        'g_tag': gTag,
        'old_id': oldId,
        'author': author,
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
