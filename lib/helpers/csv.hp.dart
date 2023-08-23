import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../models/datatable.md.dart';

class CsvHelper {
  static const String carPropertiesMockDataPath =
      'assets/mock_data/car_properties.csv';

  static Future<List<List<dynamic>>> _loadCsv() async {
    List<List<dynamic>> data = [];
    try {
      final rawData = await rootBundle.loadString(carPropertiesMockDataPath);
      data = const CsvToListConverter().convert(rawData);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  static Future<DataTabelTitleModel?> loadTitle() async {
    try {
      var csvData = await _loadCsv();
      if (csvData.isNotEmpty) {
        var titleList = csvData.first;
        List<String> titles = [];
        for (var title in titleList) {
          titles.add(title.toString());
        }
        return DataTabelTitleModel(isSelected: false, titles: titles);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<String>> loadVehicleList() async {
    try {
      var csvData = await _loadCsv();
      if (csvData.isNotEmpty) {
        /// Remove title
        csvData.removeAt(0);

        List<String> listJson = [];

        for (var dataList in csvData) {
          /// Check is 5 data cell
          if (dataList.length == 5) {
            String plateNum = dataList.asMap()[0].toString();
            String color = dataList.asMap()[1].toString();
            String propellant = dataList.asMap()[2].toString();
            String seat = dataList.asMap()[3].toString();
            String expiry = dataList.asMap()[4].toString();

            Map<String, String> map = {
              'car_plate_number': plateNum,
              'color': color,
              'propellant': propellant,
              'number_of_seat': seat,
              'expiry_date': expiry,
            };

            String jsonStr = json.encode(map);

            listJson.add(jsonStr);
          }
        }

        return listJson;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  static Future<File?> _getLocalPath() async {
    try {
      Directory appDir = await getApplicationDocumentsDirectory();
      File jsonFile = File('${appDir.path}/data.json');
      if (await jsonFile.exists()) {
        return jsonFile;
      } else {
        jsonFile.create();
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  static void _writeJson({
    required String key,
    required String value,
  }) {
    
  }
}
