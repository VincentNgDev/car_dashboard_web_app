import 'vehicle.md.dart';

class DataTableModel {
  bool isSelected;
  VehicleModel vehicle;
  DataTableModel({
    required this.isSelected,
    required this.vehicle,
  });
}

class DataTabelTitleModel {
  bool isSelected;
  List<String> titles;
  DataTabelTitleModel({
    required this.isSelected,
    required this.titles,
  });
}