// To parse this JSON data, do
//
//     final slideData = slideDataFromJson(jsonString);

import 'dart:convert';

SlideData slideDataFromJson(String str) => SlideData.fromJson(json.decode(str));

String slideDataToJson(SlideData data) => json.encode(data.toJson());

class SlideData {
    SlideData({
        this.status,
        this.data,
    });

    String status;
    Data data;

    factory SlideData.fromJson(Map<String, dynamic> json) => SlideData(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.integration,
        this.rootcategory,
        this.slider,
        this.noimg,
        this.catimages,
        this.storeId,
        this.minimumOrderAmount,
        this.stores,
        this.currency,
        this.paymentImgs,
        this.voucherCat,
        this.whatsapp,
        this.celebrityId,
        this.registerOtp,
        this.mobileFormats,
        this.cmspages,
        this.payMethodImgs,
    });

    String integration;
    int rootcategory;
    List<Slider> slider;
    String noimg;
    List<Catimage> catimages;
    int storeId;
    dynamic minimumOrderAmount;
    List<dynamic> stores;
    String currency;
    List<String> paymentImgs;
    int voucherCat;
    String whatsapp;
    int celebrityId;
    String registerOtp;
    List<MobileFormat> mobileFormats;
    Cmspages cmspages;
    List<String> payMethodImgs;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        integration: json["integration"],
        rootcategory: json["rootcategory"],
        slider: List<Slider>.from(json["slider"].map((x) => Slider.fromJson(x))),
        noimg: json["noimg"],
        catimages: List<Catimage>.from(json["catimages"].map((x) => Catimage.fromJson(x))),
        storeId: json["store_id"],
        minimumOrderAmount: json["minimum_order_amount"],
        stores: List<dynamic>.from(json["stores"].map((x) => x)),
        currency: json["currency"],
        paymentImgs: List<String>.from(json["payment_imgs"].map((x) => x)),
        voucherCat: json["voucher_cat"],
        whatsapp: json["whatsapp"],
        celebrityId: json["celebrity_id"],
        registerOtp: json["register_otp"],
        mobileFormats: List<MobileFormat>.from(json["mobile_formats"].map((x) => MobileFormat.fromJson(x))),
        cmspages: Cmspages.fromJson(json["cmspages"]),
        payMethodImgs: List<String>.from(json["pay_method_imgs"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "integration": integration,
        "rootcategory": rootcategory,
        "slider": List<dynamic>.from(slider.map((x) => x.toJson())),
        "noimg": noimg,
        "catimages": List<dynamic>.from(catimages.map((x) => x.toJson())),
        "store_id": storeId,
        "minimum_order_amount": minimumOrderAmount,
        "stores": List<dynamic>.from(stores.map((x) => x)),
        "currency": currency,
        "payment_imgs": List<dynamic>.from(paymentImgs.map((x) => x)),
        "voucher_cat": voucherCat,
        "whatsapp": whatsapp,
        "celebrity_id": celebrityId,
        "register_otp": registerOtp,
        "mobile_formats": List<dynamic>.from(mobileFormats.map((x) => x.toJson())),
        "cmspages": cmspages.toJson(),
        "pay_method_imgs": List<dynamic>.from(payMethodImgs.map((x) => x)),
    };
}

class Catimage {
    Catimage({
        this.id,
        this.img,
    });

    String id;
    String img;

    factory Catimage.fromJson(Map<String, dynamic> json) => Catimage(
        id: json["id"],
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
    };
}

class Cmspages {
    Cmspages({
        this.faq,
        this.about,
        this.terms,
        this.privacy,
    });

    int faq;
    int about;
    int terms;
    int privacy;

    factory Cmspages.fromJson(Map<String, dynamic> json) => Cmspages(
        faq: json["faq"],
        about: json["about"],
        terms: json["terms"],
        privacy: json["privacy"],
    );

    Map<String, dynamic> toJson() => {
        "faq": faq,
        "about": about,
        "terms": terms,
        "privacy": privacy,
    };
}

class MobileFormat {
    MobileFormat({
        this.webiste,
        this.len,
        this.countryCode,
        this.country,
        this.id,
    });

    String webiste;
    int len;
    String countryCode;
    String country;
    int id;

    factory MobileFormat.fromJson(Map<String, dynamic> json) => MobileFormat(
        webiste: json["webiste"],
        len: json["len"],
        countryCode: json["country_code"],
        country: json["country"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "webiste": webiste,
        "len": len,
        "country_code": countryCode,
        "country": country,
        "id": id,
    };
}

class Slider {
    Slider({
        this.image,
        this.type,
        this.id,
        this.sortOrder,
    });

    String image;
    String type;
    String id;
    String sortOrder;

    factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        image: json["image"],
        type: json["type"],
        id: json["id"],
        sortOrder: json["sort_order"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "type": type,
        "id": id,
        "sort_order": sortOrder,
    };
}
