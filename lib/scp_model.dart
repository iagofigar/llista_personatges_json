// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';

class SCP {
  final String id;
  String? number;
  String? name;
  String? imageUrl;
  String? scpClass;
  String? containment;
  late MaterialColor color;
  late var image = null;

  int risk = 3;

  SCP(this.id);

  Future getImageUrl() async {
    if (imageUrl != null) {
      return;
    }
    if (int.parse(id) <= 10) {
      HttpClient http = HttpClient();
      try {
        var uri = Uri.https(
            '673e0daa0118dbfe8609f2a1.mockapi.io', '/api/scp/entity/$id');
        var request = await http.getUrl(uri);
        var response = await request.close();
        var responseBody = await response.transform(utf8.decoder).join();

        var data = json.decode(responseBody);
        number = data["scp_number"];
        name = data["name"];
        imageUrl = data["image"];
        scpClass = data["class"];
        containment = data["containment"];

        //print(levelSCP);
      } catch (exception) {
        //print(exception);
      }
    }
    else {
      imageUrl = null;
      scpClass = "Pending Review";
      containment = "";
    }

    if (imageUrl == null) {
      image = const AssetImage("assets/dataexpunged.jpg");
    }

    if (scpClass == "Safe") {
      color = Colors.green;
    }
    else if (scpClass == "Euclid") {
      color = Colors.amber;
    }
    else if (scpClass == "Keter") {
      color = Colors.red;
    }
    else if (scpClass == "Pending Review") {
      color = Colors.blue;
    }
  }
}
