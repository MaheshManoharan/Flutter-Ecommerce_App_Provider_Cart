// To parse this JSON data, do
//
//     final productDetails = productDetailsFromJson(jsonString);

import 'dart:convert';

ProductDetails productDetailsFromJson(String str) => ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
    ProductDetails({
        this.name,
        this.id,
        this.sku,
        this.evoucher,
        this.ecard,
        this.description,
        this.shortDescription,
        this.brand,
        this.image,
        this.hasOptions,
        this.productTag,
        this.preorder,
        this.preorderinfo,
        this.price,
        this.status,
        this.attrs,
    });

    String name;
    String id;
    String sku;
    int evoucher;
    int ecard;
    dynamic description;
    dynamic shortDescription;
    dynamic brand;
    List<String> image;
    int hasOptions;
    dynamic productTag;
    String preorder;
    Preorderinfo preorderinfo;
    int price;
    int status;
    Attrs attrs;

    factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        name: json["name"],
        id: json["id"],
        sku: json["sku"],
        evoucher: json["evoucher"],
        ecard: json["ecard"],
        description: json["description"],
        shortDescription: json["short_description"],
        brand: json["brand"],
        image: List<String>.from(json["image"].map((x) => x)),
        hasOptions: json["has_options"],
        productTag: json["product_tag"],
        preorder: json["preorder"],
        preorderinfo: Preorderinfo.fromJson(json["preorderinfo"]),
        price: json["price"],
        status: json["status"],
        attrs: Attrs.fromJson(json["attrs"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "sku": sku,
        "evoucher": evoucher,
        "ecard": ecard,
        "description": description,
        "short_description": shortDescription,
        "brand": brand,
        "image": List<dynamic>.from(image.map((x) => x)),
        "has_options": hasOptions,
        "product_tag": productTag,
        "preorder": preorder,
        "preorderinfo": preorderinfo.toJson(),
        "price": price,
        "status": status,
        "attrs": attrs.toJson(),
    };
}

class Attrs {
    Attrs({
        this.color,
        this.specs,
    });

    String color;
    List<Spec> specs;

    factory Attrs.fromJson(Map<String, dynamic> json) => Attrs(
        color: json["color"],
        specs: List<Spec>.from(json["specs"].map((x) => Spec.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "color": color,
        "specs": List<dynamic>.from(specs.map((x) => x.toJson())),
    };
}

class Spec {
    Spec({
        this.value,
        this.icon,
        this.title,
    });

    String value;
    String icon;
    String title;

    factory Spec.fromJson(Map<String, dynamic> json) => Spec(
        value: json["value"],
        icon: json["icon"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "icon": icon,
        "title": title,
    };
}

class Preorderinfo {
    Preorderinfo({
        this.preorderType,
        this.preorderPercentage,
        this.preorderMsg,
        this.freePreorderNote,
        this.preOrderQty,
        this.isPreorderProduct,
        this.availabilityOn,
    });

    String preorderType;
    String preorderPercentage;
    String preorderMsg;
    String freePreorderNote;
    String preOrderQty;
    String isPreorderProduct;
    String availabilityOn;

    factory Preorderinfo.fromJson(Map<String, dynamic> json) => Preorderinfo(
        preorderType: json["preorderType"],
        preorderPercentage: json["preorderPercentage"],
        preorderMsg: json["preorderMsg"],
        freePreorderNote: json["freePreorderNote"],
        preOrderQty: json["preOrderQty"],
        isPreorderProduct: json["isPreorderProduct"],
        availabilityOn: json["availabilityOn"],
    );

    Map<String, dynamic> toJson() => {
        "preorderType": preorderType,
        "preorderPercentage": preorderPercentage,
        "preorderMsg": preorderMsg,
        "freePreorderNote": freePreorderNote,
        "preOrderQty": preOrderQty,
        "isPreorderProduct": isPreorderProduct,
        "availabilityOn": availabilityOn,
    };
}
