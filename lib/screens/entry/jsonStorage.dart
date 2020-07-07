import 'EntryPage.dart';
import 'pageOne.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app.dart';

class JSONStorage {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File("$path/jsonStorage.txt");
  }

  static Future<String> readJSONStorage() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      // debugPrint("reading readJSONStorage file stuff: " + contents);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('jsonFileString', contents);
      return contents;
    } catch (err) {
      return "";
    }
  }

  static Future<File> writeJSONStorage(String str) async {
    final file = await _localFile;
    readJSONStorage();
    return file.writeAsString(str);
  }

  static Future<List<ListItem>> getItems() async {
    return items;
  }
}
