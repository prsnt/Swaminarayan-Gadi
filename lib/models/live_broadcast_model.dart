class LiveBroadcastModel {
  LiveBroadcastModel({
    this.isError,
    this.message,
    this.data,
  });

  LiveBroadcastModel.fromJson(Map<String, dynamic> json)
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
    this.liveBroadCastList,
  });

  Data.fromJson(Map<String, dynamic> json)
      : total = json['total'] as int?,
        perpage = json['perpage'] as int?,
        currentpage = json['currentpage'] as int?,
        totalpages = json['totalpages'] as int?,
        nextpage = json['nextpage'] as int?,
        remainingCount = json['remainingCount'] as int?,
        liveBroadCastList = (json['data'] as List?)?.map((dynamic e) => LiveBroadCastData.fromJson(e as Map<String, dynamic>)).toList();
  final int? total;
  final int? perpage;
  final int? currentpage;
  final int? totalpages;
  final int? nextpage;
  final int? remainingCount;
  final List<LiveBroadCastData>? liveBroadCastList;

  Map<String, dynamic> toJson() => {
        'total': total,
        'perpage': perpage,
        'currentpage': currentpage,
        'totalpages': totalpages,
        'nextpage': nextpage,
        'remainingCount': remainingCount,
        'data': liveBroadCastList?.map((e) => e.toJson()).toList()
      };
}

class LiveBroadCastData {
  LiveBroadCastData({
    this.id,
    this.name,
    this.slug,
    this.gTag,
    this.siteAccess,
    this.category,
    this.date,
    this.location,
    this.image,
    this.imageAlt,
    this.broadcast,
    this.broadcastEvent,
    this.showEvent,
    this.view360Active,
    this.startTime,
    this.endTime,
    this.schedule,
    this.description,
    this.timezone,
    this.streamId,
    this.livePage,
    this.streamtext,
    this.guid,
    this.streamProvider,
    this.pdfFile,
    this.feature,
    this.displayOrder,
    this.createdDate,
    this.createdBy,
    this.status,
    this.v,
    this.updatedBy,
    this.updatedDate,
    this.uploadLocation,
    this.eventDay,
    this.eventId,
    this.eventType,
    this.istStartTime,
    this.istEndTime,
  });

  LiveBroadCastData.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        name = json['name'] as String?,
        slug = json['slug'] as String?,
        gTag = json['g_tag'] as String?,
        siteAccess = json['siteAccess'] as String?,
        category = json['category'] as String?,
        date = json['date'] as String?,
        location = json['location'] as String?,
        image = json['image'] as String?,
        imageAlt = json['image_alt'] as String?,
        broadcast = json['broadcast'] as String?,
        broadcastEvent = json['broadcastEvent'] as String?,
        showEvent = json['show_event'] as String?,
        view360Active = json['view_360_active'] as String?,
        startTime = json['startTime'] as String?,
        endTime = json['endTime'] as String?,
        schedule = json['schedule'] as String?,
        description = json['description'] as String?,
        timezone = json['timezone'] as String?,
        streamId = json['streamId'] as String?,
        livePage = json['livePage'] as String?,
        streamtext = json['streamtext'] as String?,
        guid = json['guid'] as String?,
        streamProvider = json['stream_provider'] as String?,
        pdfFile = json['pdf_file'] as String?,
        feature = json['feature'] as String?,
        displayOrder = json['displayOrder'] as int?,
        createdDate = json['createdDate'] as String?,
        createdBy = json['createdBy'] as String?,
        status = json['status'] as String?,
        v = json['__v'] as int?,
        updatedBy = json['updatedBy'] as String?,
        updatedDate = json['updatedDate'] as String?,
        uploadLocation = json['upload_location'] as String?,
        eventDay = json['event_day'] as String?,
        eventId = json['event_id'] as String?,
        eventType = json['event_type'] as String?,
        istStartTime = json['ist_startTime'] as String?,
        istEndTime = json['ist_endTime'] as String?;
  final String? id;
  final String? name;
  final String? slug;
  final String? gTag;
  final String? siteAccess;
  final String? category;
  final String? date;
  final String? location;
  final String? image;
  final String? imageAlt;
  final String? broadcast;
  final String? broadcastEvent;
  final String? showEvent;
  final String? view360Active;
  final String? startTime;
  final String? endTime;
  final String? schedule;
  final String? description;
  final String? timezone;
  final String? streamId;
  final String? livePage;
  final String? streamtext;
  final String? guid;
  final String? streamProvider;
  final String? pdfFile;
  final String? feature;
  final int? displayOrder;
  final String? createdDate;
  final String? createdBy;
  final String? status;
  final int? v;
  final String? updatedBy;
  final String? updatedDate;
  final String? uploadLocation;
  final String? eventDay;
  final String? eventId;
  final String? eventType;
  final String? istStartTime;
  final String? istEndTime;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'slug': slug,
        'g_tag': gTag,
        'siteAccess': siteAccess,
        'category': category,
        'date': date,
        'location': location,
        'image': image,
        'image_alt': imageAlt,
        'broadcast': broadcast,
        'broadcastEvent': broadcastEvent,
        'show_event': showEvent,
        'view_360_active': view360Active,
        'startTime': startTime,
        'endTime': endTime,
        'schedule': schedule,
        'description': description,
        'timezone': timezone,
        'streamId': streamId,
        'livePage': livePage,
        'streamtext': streamtext,
        'guid': guid,
        'stream_provider': streamProvider,
        'pdf_file': pdfFile,
        'feature': feature,
        'displayOrder': displayOrder,
        'createdDate': createdDate,
        'createdBy': createdBy,
        'status': status,
        '__v': v,
        'updatedBy': updatedBy,
        'updatedDate': updatedDate,
        'upload_location': uploadLocation,
        'event_day': eventDay,
        'event_id': eventId,
        'event_type': eventType,
        'ist_startTime': istStartTime,
        'ist_endTime': istEndTime
      };
}
