class DailyDarshanModel {
  DailyDarshanModel({
    this.isError,
    this.message,
    this.data,
  });

  DailyDarshanModel.fromJson(Map<String, dynamic> json)
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
    this.cmspage,
    this.type,
    this.pageType,
    this.title,
    this.uploadLocation,
    this.align,
    this.pClass,
    this.mClass,
    this.dStyle,
    this.imageJson,
    this.noOfTab,
    this.tabJson,
    this.buttonJson,
    this.factsJson,
    this.liveJson,
    this.displayOrder,
    this.createdDate,
    this.createdBy,
    this.status,
    this.v,
    this.updatedBy,
    this.updatedDate,
    this.deleted,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        cmspage = json['cmspage'] as String?,
        type = json['type'] as String?,
        pageType = json['pageType'] as String?,
        title = json['title'] as String?,
        uploadLocation = json['upload_location'] as String?,
        align = json['align'] as String?,
        pClass = json['pClass'] as String?,
        mClass = json['mClass'] as String?,
        dStyle = json['dStyle'] as String?,
        imageJson = json['image_json'] as List?,
        noOfTab = json['noOfTab'] as String?,
        tabJson = json['tab_json'] as List?,
        buttonJson = json['button_json'] as List?,
        factsJson = json['facts_json'] as List?,
        liveJson = (json['live_json'] as List?)?.map((dynamic e) => LiveJson.fromJson(e as Map<String, dynamic>)).toList(),
        displayOrder = json['displayOrder'] as int?,
        createdDate = json['createdDate'] as String?,
        createdBy = json['createdBy'] as String?,
        status = json['status'] as String?,
        v = json['__v'] as int?,
        updatedBy = json['updatedBy'] as String?,
        updatedDate = json['updatedDate'] as String?,
        deleted = json['deleted'] as String?;
  final String? id;
  final String? cmspage;
  final String? type;
  final String? pageType;
  final String? title;
  final String? uploadLocation;
  final String? align;
  final String? pClass;
  final String? mClass;
  final String? dStyle;
  final List<dynamic>? imageJson;
  final String? noOfTab;
  final List<dynamic>? tabJson;
  final List<dynamic>? buttonJson;
  final List<dynamic>? factsJson;
  final List<LiveJson>? liveJson;
  final int? displayOrder;
  final String? createdDate;
  final String? createdBy;
  final String? status;
  final int? v;
  final String? updatedBy;
  final String? updatedDate;
  final String? deleted;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'cmspage': cmspage,
        'type': type,
        'pageType': pageType,
        'title': title,
        'upload_location': uploadLocation,
        'align': align,
        'pClass': pClass,
        'mClass': mClass,
        'dStyle': dStyle,
        'image_json': imageJson,
        'noOfTab': noOfTab,
        'tab_json': tabJson,
        'button_json': buttonJson,
        'facts_json': factsJson,
        'live_json': liveJson?.map((e) => e.toJson()).toList(),
        'displayOrder': displayOrder,
        'createdDate': createdDate,
        'createdBy': createdBy,
        'status': status,
        '__v': v,
        'updatedBy': updatedBy,
        'updatedDate': updatedDate,
        'deleted': deleted
      };
}

class LiveJson {
  LiveJson({
    this.stream,
    this.isStream,
    this.imgSlug,
    this.title,
    this.desc,
    this.images,
  });

  LiveJson.fromJson(Map<String, dynamic> json)
      : stream = json['stream'] as String?,
        isStream = json['is_stream'] as String?,
        imgSlug = json['img_slug'] as String?,
        title = json['title'] as String?,
        desc = json['desc'] as String?,
        images = json['images'] as List?;
  final String? stream;
  final String? isStream;
  final String? imgSlug;
  final String? title;
  final String? desc;
  final List<dynamic>? images;

  Map<String, dynamic> toJson() => {'stream': stream, 'is_stream': isStream, 'img_slug': imgSlug, 'title': title, 'desc': desc, 'images': images};
}
