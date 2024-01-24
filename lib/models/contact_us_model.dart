class ContactUsModel {
  ContactUsModel({
    this.isError,
    this.message,
    this.data,
  });

  ContactUsModel.fromJson(Map<String, dynamic> json)
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
    this.name,
    this.slug,
    this.feature,
    this.displayOrder,
    this.createdDate,
    this.createdBy,
    this.status,
    this.v,
    this.updatedBy,
    this.updatedDate,
    this.mandirId,
    this.isMain,
    this.siteTitle,
    this.buttonColor,
    this.buttonHColor,
    this.fontFamily,
    this.fontSize,
    this.mainColor,
    this.menuStyle,
    this.secondColor,
    this.siteFavicon,
    this.siteLogo,
    this.siteImg,
    this.footerAboutDesc,
    this.footerContactLat,
    this.footerContactLocation,
    this.footerContactLong,
    this.footerContactTitle,
    this.footerDesc,
    this.footerSubscribeTitle,
    this.acharyaMaharajName,
    this.copyright,
    this.footerAbout,
    this.footerLogoAlt,
    this.footerLogoDesc,
    this.footerLogo,
    this.footerContactEmail,
    this.footerContactFacebook,
    this.footerContactInstagram,
    this.footerContactNumber,
    this.footerContactNumber2,
    this.footerContactTwitter,
    this.footerContactWhatsapp,
    this.footerContactYoutube,
    this.siteId,
    this.siteLogoThumb,
    this.siteFaviconThumb,
    this.siteImgThumb,
    this.footerLogoThumb,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        name = json['name'] as String?,
        slug = json['slug'] as String?,
        feature = json['feature'] as String?,
        displayOrder = json['displayOrder'] as int?,
        createdDate = json['createdDate'] as String?,
        createdBy = json['createdBy'] as String?,
        status = json['status'] as String?,
        v = json['__v'] as int?,
        updatedBy = json['updatedBy'] as String?,
        updatedDate = json['updatedDate'] as String?,
        mandirId = json['mandir_id'] as String?,
        isMain = json['is_main'] as String?,
        siteTitle = json['site_title'] as String?,
        buttonColor = json['buttonColor'] as String?,
        buttonHColor = json['buttonHColor'] as String?,
        fontFamily = json['fontFamily'] as String?,
        fontSize = json['fontSize'] as String?,
        mainColor = json['mainColor'] as String?,
        menuStyle = json['menuStyle'] as String?,
        secondColor = json['secondColor'] as String?,
        siteFavicon = json['site_favicon'] as String?,
        siteLogo = json['site_logo'] as String?,
        siteImg = json['site_img'] as String?,
        footerAboutDesc = json['footer_about_desc'] as String?,
        footerContactLat = json['footer_contact_lat'] as String?,
        footerContactLocation = json['footer_contact_location'] as String?,
        footerContactLong = json['footer_contact_long'] as String?,
        footerContactTitle = json['footer_contact_title'] as String?,
        footerDesc = json['footer_desc'] as String?,
        footerSubscribeTitle = json['footer_subscribe_title'] as String?,
        acharyaMaharajName = json['acharya_maharaj_name'] as String?,
        copyright = json['copyright'] as String?,
        footerAbout = json['footer_about'] as String?,
        footerLogoAlt = json['footer_logo_alt'] as String?,
        footerLogoDesc = json['footer_logo_desc'] as String?,
        footerLogo = json['footer_logo'] as String?,
        footerContactEmail = json['footer_contact_email'] as String?,
        footerContactFacebook = json['footer_contact_facebook'] as String?,
        footerContactInstagram = json['footer_contact_instagram'] as String?,
        footerContactNumber = json['footer_contact_number'] as String?,
        footerContactNumber2 = json['footer_contact_number2'] as String?,
        footerContactTwitter = json['footer_contact_twitter'] as String?,
        footerContactWhatsapp = json['footer_contact_whatsapp'] as String?,
        footerContactYoutube = json['footer_contact_youtube'] as String?,
        siteId = json['site_id'] as String?,
        siteLogoThumb = json['site_logo_Thumb'] as String?,
        siteFaviconThumb = json['site_favicon_Thumb'] as String?,
        siteImgThumb = json['site_img_Thumb'] as String?,
        footerLogoThumb = json['footer_logo_Thumb'] as String?;
  final String? id;
  final String? name;
  final String? slug;
  final String? feature;
  final int? displayOrder;
  final String? createdDate;
  final String? createdBy;
  final String? status;
  final int? v;
  final String? updatedBy;
  final String? updatedDate;
  final String? mandirId;
  final String? isMain;
  final String? siteTitle;
  final String? buttonColor;
  final String? buttonHColor;
  final String? fontFamily;
  final String? fontSize;
  final String? mainColor;
  final String? menuStyle;
  final String? secondColor;
  final String? siteFavicon;
  final String? siteLogo;
  final String? siteImg;
  final String? footerAboutDesc;
  final String? footerContactLat;
  final String? footerContactLocation;
  final String? footerContactLong;
  final String? footerContactTitle;
  final String? footerDesc;
  final String? footerSubscribeTitle;
  final String? acharyaMaharajName;
  final String? copyright;
  final String? footerAbout;
  final String? footerLogoAlt;
  final String? footerLogoDesc;
  final String? footerLogo;
  final String? footerContactEmail;
  final String? footerContactFacebook;
  final String? footerContactInstagram;
  final String? footerContactNumber;
  final String? footerContactNumber2;
  final String? footerContactTwitter;
  final String? footerContactWhatsapp;
  final String? footerContactYoutube;
  final String? siteId;
  final String? siteLogoThumb;
  final String? siteFaviconThumb;
  final String? siteImgThumb;
  final String? footerLogoThumb;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'slug': slug,
        'feature': feature,
        'displayOrder': displayOrder,
        'createdDate': createdDate,
        'createdBy': createdBy,
        'status': status,
        '__v': v,
        'updatedBy': updatedBy,
        'updatedDate': updatedDate,
        'mandir_id': mandirId,
        'is_main': isMain,
        'site_title': siteTitle,
        'buttonColor': buttonColor,
        'buttonHColor': buttonHColor,
        'fontFamily': fontFamily,
        'fontSize': fontSize,
        'mainColor': mainColor,
        'menuStyle': menuStyle,
        'secondColor': secondColor,
        'site_favicon': siteFavicon,
        'site_logo': siteLogo,
        'site_img': siteImg,
        'footer_about_desc': footerAboutDesc,
        'footer_contact_lat': footerContactLat,
        'footer_contact_location': footerContactLocation,
        'footer_contact_long': footerContactLong,
        'footer_contact_title': footerContactTitle,
        'footer_desc': footerDesc,
        'footer_subscribe_title': footerSubscribeTitle,
        'acharya_maharaj_name': acharyaMaharajName,
        'copyright': copyright,
        'footer_about': footerAbout,
        'footer_logo_alt': footerLogoAlt,
        'footer_logo_desc': footerLogoDesc,
        'footer_logo': footerLogo,
        'footer_contact_email': footerContactEmail,
        'footer_contact_facebook': footerContactFacebook,
        'footer_contact_instagram': footerContactInstagram,
        'footer_contact_number': footerContactNumber,
        'footer_contact_number2': footerContactNumber2,
        'footer_contact_twitter': footerContactTwitter,
        'footer_contact_whatsapp': footerContactWhatsapp,
        'footer_contact_youtube': footerContactYoutube,
        'site_id': siteId,
        'site_logo_Thumb': siteLogoThumb,
        'site_favicon_Thumb': siteFaviconThumb,
        'site_img_Thumb': siteImgThumb,
        'footer_logo_Thumb': footerLogoThumb
      };
}
