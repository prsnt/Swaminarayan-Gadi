class HomeModel {
  HomeModel({
    this.isError,
    this.message,
    this.data,
  });

  HomeModel.fromJson(Map<String, dynamic> json)
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
    this.tSlider,
    this.imageJson,
    this.displayOrder,
    this.createdDate,
    this.createdBy,
    this.status,
    this.v,
    this.updatedBy,
    this.updatedDate,
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
        tSlider = json['tSlider'] as String?,
        imageJson = (json['image_json'] as List?)?.map((dynamic e) => ImageJson.fromJson(e as Map<String, dynamic>)).toList(),
        displayOrder = json['displayOrder'] as int?,
        createdDate = json['createdDate'] as String?,
        createdBy = json['createdBy'] as String?,
        status = json['status'] as String?,
        v = json['__v'] as int?,
        updatedBy = json['updatedBy'] as String?,
        updatedDate = json['updatedDate'] as String?;
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
  final String? tSlider;
  final List<ImageJson>? imageJson;
  final int? displayOrder;
  final String? createdDate;
  final String? createdBy;
  final String? status;
  final int? v;
  final String? updatedBy;
  final String? updatedDate;

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
        'tSlider': tSlider,
        'image_json': imageJson?.map((e) => e.toJson()).toList(),
        'displayOrder': displayOrder,
        'createdDate': createdDate,
        'createdBy': createdBy,
        'status': status,
        '__v': v,
        'updatedBy': updatedBy,
        'updatedDate': updatedDate
      };
}

class ImageJson {
  ImageJson({
    this.imgName,
    this.imgPopupName,
    this.position,
    this.lastModified,
    this.lastModifiedDate,
    this.image,
    this.sIAlt,
    this.sIPopupAlt,
    this.sTitle,
    this.sHeader,
    this.sDesc,
    this.sLTitle,
    this.sLUrl,
    this.sVideoUrl,
    this.sDate,
    this.sColour,
    this.imageurl,
  });

  ImageJson.fromJson(Map<String, dynamic> json)
      : imgName = json['img_name'] as String?,
        imgPopupName = json['img_popup_name'] as String?,
        position = json['position'] as String?,
        lastModified = json['lastModified'] as String?,
        lastModifiedDate = json['lastModifiedDate'] as String?,
        image = json['image'] as String?,
        sIAlt = json['s_i_alt'] as String?,
        sIPopupAlt = json['s_i_popup_alt'] as String?,
        sTitle = json['s_title'] as String?,
        sHeader = json['s_header'] as String?,
        sDesc = json['s_desc'] as String?,
        sLTitle = json['s_l_title'] as String?,
        sLUrl = json['s_l_url'] as String?,
        sVideoUrl = json['s_video_url'] as String?,
        sDate = json['s_date'] as String?,
        sColour = json['s_colour'] as String?,
        imageurl = json['imageurl'] as String?;
  final String? imgName;
  final String? imgPopupName;
  final String? position;
  final String? lastModified;
  final String? lastModifiedDate;
  final String? image;
  final String? sIAlt;
  final String? sIPopupAlt;
  final String? sTitle;
  final String? sHeader;
  final String? sDesc;
  final String? sLTitle;
  final String? sLUrl;
  final String? sVideoUrl;
  final String? sDate;
  final String? sColour;
  final String? imageurl;

  Map<String, dynamic> toJson() => {
        'img_name': imgName,
        'img_popup_name': imgPopupName,
        'position': position,
        'lastModified': lastModified,
        'lastModifiedDate': lastModifiedDate,
        'image': image,
        's_i_alt': sIAlt,
        's_i_popup_alt': sIPopupAlt,
        's_title': sTitle,
        's_header': sHeader,
        's_desc': sDesc,
        's_l_title': sLTitle,
        's_l_url': sLUrl,
        's_video_url': sVideoUrl,
        's_date': sDate,
        's_colour': sColour,
        'imageurl': imageurl
      };
}
