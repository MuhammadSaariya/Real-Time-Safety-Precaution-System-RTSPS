// To parse this JSON data, do
//
//     final items = itemsFromMap(jsonString);

import 'dart:convert';

List<Items> itemsFromMap(String str) => List<Items>.from(json.decode(str).map((x) => Items.fromMap(x)));

String itemsToMap(List<Items> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Items {
    Items({
        this.labels,
        this.data,
    });

    String labels;
    double data;

    factory Items.fromMap(Map<String, dynamic> json) => Items(
        labels: json["Labels"],
        data: json["data"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "Labels": labels,
        "data": data,
    };
}
