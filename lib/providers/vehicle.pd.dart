import 'dart:convert';

import 'package:flutter/material.dart';

import '../helpers/csv.hp.dart';
import '../models/datatable.md.dart';
import '../models/vehicle.md.dart';

class VehicleProvider extends ChangeNotifier {
  List<VehicleModel> _cars = [];
  List<VehicleModel> get cars {
    return [..._cars];
  }

  Future loadCarListing() async {
    try {
      await CsvHelper.loadVehicleList().then((value) {
        List<VehicleModel> tempCars = [];
        for (var item in value) {
          var decodedJson = json.decode(item);
          tempCars.add(VehicleModel.fromJson(decodedJson));
        }
        _cars = tempCars;
        notifyListeners();

        List<DataTableModel> tempDataTableCells = [];
        for (var car in _cars) {
          tempDataTableCells.add(
            DataTableModel(
              isSelected: false,
              vehicle: car,
            ),
          );
        }
        _dataTableCells = tempDataTableCells;
        notifyListeners();
      });
    } catch (e) {
      rethrow;
    }
  }

  List<DataTableModel> _dataTableCells = [];
  List<DataTableModel> get dataTableCells {
    return [..._dataTableCells];
  }

  DataTabelTitleModel? _dataTableTitleModel;
  DataTabelTitleModel? get dataTabelTitleModel {
    return _dataTableTitleModel;
  }

  void selectCar({required int index, required bool value}) {
    print(value);
    if (_dataTableCells.asMap()[index] != null) {
      _dataTableCells[index].isSelected = value;
      notifyListeners();
    }
  }

  Future loadDataTableTitle() async {
    _dataTableTitleModel = await CsvHelper.loadTitle();
  }

  void allSelection(bool isSelected) {
    if (_dataTableTitleModel != null) {
      _dataTableTitleModel!.isSelected = isSelected;
      for (var data in _dataTableCells) {
        if (_dataTableTitleModel!.isSelected) {
          data.isSelected = true;
        } else {
          data.isSelected = false;
        }
      }
      notifyListeners();
    }
  }

  bool _isAllCars = false;
  bool get isAllCars {
    return _isAllCars;
  }

  
}
