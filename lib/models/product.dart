// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => 
List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    Product({
        this.type,
        this.data,
        this.subtype,
    });

    String type;
    Data data;
    String subtype;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        type: json["type"],
        data: Data.fromJson(json["data"]),
        subtype: json["subtype"] == null ? null : json["subtype"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "data": data.toJson(),
        "subtype": subtype == null ? null : subtype,
    };
}

class Data {
    Data({
        this.id,
        this.title,
        this.items,
        this.type,
        this.file,
    });

    String id;
    String title;
    List<Item> items;
    String type;
    String file;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"] == null ? null : json["title"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        type: json["type"] == null ? null : json["type"],
        file: json["file"] == null ? null : json["file"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title == null ? null : title,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
        "type": type == null ? null : type,
        "file": file == null ? null : file,
    };
}

class Item {
    Item({
        this.name,
        this.id,
        this.sku,
        this.image,
        this.price,
        this.storage,
        this.productTag,
        this.preorder,
        this.specialPrice,
        this.rating,
    });

    String name;
    String id;
    String sku;
    String image;
    double price;
    dynamic storage;
    String productTag;
    String preorder;
    int specialPrice;
    String rating;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        id: json["id"],
        sku: json["sku"],
        image: json["image"],
        price: json["price"].toDouble(),
        storage: json["storage"],
        productTag: json["product_tag"] == null ? null : json["product_tag"],
        preorder: json["preorder"] == null ? null : json["preorder"],
        specialPrice: json["special_price"] == null ? null : json["special_price"],
        rating: json["rating"] == null ? null : json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "sku": sku,
        "image": image,
        "price": price,
        "storage": storage,
        "product_tag": productTag == null ? null : productTag,
        "preorder": preorder == null ? null : preorder,
        "special_price": specialPrice == null ? null : specialPrice,
        "rating": rating == null ? null : rating,
    };
}
