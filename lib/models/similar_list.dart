// To parse this JSON data, do
//
//     final similarList = similarListFromJson(jsonString);

import 'dart:convert';

SimilarList similarListFromJson(String str) => SimilarList.fromJson(json.decode(str));

String similarListToJson(SimilarList data) => json.encode(data.toJson());

class SimilarList {
    SimilarList({
        this.currency,
        this.status,
        this.items,
    });

    String currency;
    String status;
    List<Item> items;

    factory SimilarList.fromJson(Map<String, dynamic> json) => SimilarList(
        currency: json["currency"],
        status: json["status"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "currency": currency,
        "status": status,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    Item({
        this.name,
        this.id,
        this.sku,
        this.storage,
        this.productTag,
        this.preorder,
        this.image,
        this.isNew,
        this.price,
    });

    String name;
    String id;
    String sku;
    dynamic storage;
    dynamic productTag;
    String preorder;
    String image;
    int isNew;
    int price;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        id: json["id"],
        sku: json["sku"],
        storage: json["storage"],
        productTag: json["product_tag"],
        preorder: json["preorder"] == null ? null : json["preorder"],
        image: json["image"],
        isNew: json["is_new"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "sku": sku,
        "storage": storage,
        "product_tag": productTag,
        "preorder": preorder == null ? null : preorder,
        "image": image,
        "is_new": isNew,
        "price": price,
    };
}
