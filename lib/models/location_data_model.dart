class LocationDataModel {
  LocationDataModel({
    this.isError,
    this.message,
    this.mainData,
  });

  LocationDataModel.fromJson(Map<String, dynamic> json)
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
        data = (json['data'] as List?)?.map((dynamic e) => LocationData.fromJson(e as Map<String, dynamic>)).toList();
  final int? total;
  final int? perpage;
  final int? currentpage;
  final int? totalpages;
  final int? nextpage;
  final int? remainingCount;
  final List<LocationData>? data;

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

class LocationData {
  LocationData(
      {this.id,
      this.title,
      this.slug,
      this.oldId,
      this.type,
      this.registeredName,
      this.region,
      this.gTag,
      this.tagline,
      this.header,
      this.image,
      this.imageAlt,
      this.twitter,
      this.youtube,
      this.facebook,
      this.instagram,
      this.whatsapp,
      this.websiteUrl,
      this.email,
      this.telephone1,
      this.telephone2,
      this.telephone3,
      this.sevashramTel,
      this.fax,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country,
      this.lat,
      this.long,
      this.metaTitle,
      this.metaDescription,
      this.feature,
      this.displayOrder,
      this.createdDate,
      this.createdBy,
      this.status,
      this.v,
      this.imageThumb});

  LocationData.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        title = json['title'] as String?,
        slug = json['slug'] as String?,
        oldId = json['old_id'] as String?,
        type = json['type'] as String?,
        registeredName = json['registered_name'] as String?,
        region = json['region'] as String?,
        gTag = json['g_tag'] as String?,
        tagline = json['tagline'] as String?,
        header = json['header'] as String?,
        image = json['image'] as String?,
        imageAlt = json['image_alt'] as String?,
        twitter = json['twitter'] as String?,
        youtube = json['youtube'] as String?,
        facebook = json['facebook'] as String?,
        instagram = json['instagram'] as String?,
        whatsapp = json['whatsapp'] as String?,
        websiteUrl = json['website_url'] as String?,
        email = json['email'] as String?,
        telephone1 = json['telephone_1'] as String?,
        telephone2 = json['telephone_2'] as String?,
        telephone3 = json['telephone_3'] as String?,
        sevashramTel = json['sevashram_tel'] as String?,
        fax = json['fax'] as String?,
        address1 = json['address_1'] as String?,
        address2 = json['address_2'] as String?,
        city = json['city'] as String?,
        state = json['state'] as String?,
        postcode = json['postcode'] as String?,
        country = json['country'] as String?,
        lat = json['lat'] as String?,
        long = json['long'] as String?,
        metaTitle = json['metaTitle'] as String?,
        metaDescription = json['metaDescription'] as String?,
        feature = json['feature'] as String?,
        displayOrder = json['displayOrder'] as int?,
        createdDate = json['createdDate'] as String?,
        createdBy = json['createdBy'] as String?,
        status = json['status'] as String?,
        v = json['__v'] as int?,
        imageThumb = json['image_Thumb'] as String?;
  final String? id;
  final String? title;
  final String? slug;
  final String? oldId;
  final String? type;
  final String? registeredName;
  final String? region;
  final String? gTag;
  final String? tagline;
  final String? header;
  final String? image;
  final String? imageAlt;
  final String? twitter;
  final String? youtube;
  final String? facebook;
  final String? instagram;
  final String? whatsapp;
  final String? websiteUrl;
  final String? email;
  final String? telephone1;
  final String? telephone2;
  final String? telephone3;
  final String? sevashramTel;
  final String? fax;
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? postcode;
  final String? country;
  final String? lat;
  final String? long;
  final String? metaTitle;
  final String? metaDescription;
  final String? feature;
  final int? displayOrder;
  final String? createdDate;
  final String? createdBy;
  final String? status;
  final int? v;
  final String? imageThumb;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'slug': slug,
        'old_id': oldId,
        'type': type,
        'registered_name': registeredName,
        'region': region,
        'g_tag': gTag,
        'tagline': tagline,
        'header': header,
        'image': image,
        'image_alt': imageAlt,
        'twitter': twitter,
        'youtube': youtube,
        'facebook': facebook,
        'instagram': instagram,
        'whatsapp': whatsapp,
        'website_url': websiteUrl,
        'email': email,
        'telephone_1': telephone1,
        'telephone_2': telephone2,
        'telephone_3': telephone3,
        'sevashram_tel': sevashramTel,
        'fax': fax,
        'address_1': address1,
        'address_2': address2,
        'city': city,
        'state': state,
        'postcode': postcode,
        'country': country,
        'lat': lat,
        'long': long,
        'metaTitle': metaTitle,
        'metaDescription': metaDescription,
        'feature': feature,
        'displayOrder': displayOrder,
        'createdDate': createdDate,
        'createdBy': createdBy,
        'status': status,
        '__v': v,
        'image_Thumb': imageThumb
      };
}
