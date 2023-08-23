import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_car_dashboard/models/vehicle.md.dart';

import '../models/datatable.md.dart';
import '../providers/vehicle.pd.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({super.key});

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  bool _isLoading = false;
  List<VehicleModel> _carList = [];
  List<DataTableModel> _dataTableCells = [];
  DataTabelTitleModel? _dataTableTitleModel;

  /// Function Section
  void buildFn() {
    var carPd = Provider.of<VehicleProvider>(context);
    _carList = carPd.cars;
    _dataTableCells = carPd.dataTableCells;
    _dataTableTitleModel = carPd.dataTabelTitleModel;
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      setState(() {
        _isLoading = true;
      });
      await loadData().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  Future loadData() async {
    var carPd = Provider.of<VehicleProvider>(context, listen: false);
    carPd.loadCarListing();
    carPd.loadDataTableTitle();
  }

  /// Widget Section
  List<DataColumn> _dataColumns() {
    return [
      // Checkbox
      DataColumn(
        label: Checkbox(
          value: _dataTableTitleModel?.isSelected ?? false,
          onChanged: (value) {
            var carPd = Provider.of<VehicleProvider>(context, listen: false);
            carPd.allSelection(value ?? false);
          },
        ),
      ),
      ...List.generate(_dataTableTitleModel?.titles.length ?? 0, (index) {
        String titleStr = _dataTableTitleModel?.titles[index] ?? '';
        return DataColumn(
          label: Text(
            titleStr,
            style: const TextStyle(),
          ),
        );
      }),
    ];
  }

  List<DataRow> _dataRows() {
    return List.generate(_dataTableCells.length, (index) {
      var isSelected = _dataTableCells[index].isSelected;
      var car = _dataTableCells[index].vehicle;
      return DataRow(
        cells: [
          /// Checkbox
          DataCell(
            Checkbox(
              value: isSelected,
              onChanged: (value) {
                var carPd = Provider.of<VehicleProvider>(
                  context,
                  listen: false,
                );
                carPd.selectCar(index: index, value: value ?? false);
              },
            ),
          ),

          /// Car properties
          DataCell(
            Text(
              car.carPlateNum,
              style: const TextStyle(),
            ),
          ),
          DataCell(
            Text(
              car.color,
              style: const TextStyle(),
            ),
          ),
          DataCell(
            Text(
              car.propellant,
              style: const TextStyle(),
            ),
          ),
          DataCell(
            Text(
              car.seatNum,
              style: const TextStyle(),
            ),
          ),
          DataCell(
            Text(
              car.expiryDate,
              style: const TextStyle(),
            ),
          ),
        ],
      );
    });
  }

  Widget tab(String title, bool isSelected) {
    return Container(
      width: 300,
      height: 50,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected
                      ? const Color.fromARGB(204, 240, 224, 83)
                      : Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 5,
            color: isSelected
                ? const Color.fromARGB(204, 240, 224, 83)
                : Colors.white,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    buildFn();
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: Colors.white,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                ),
              )
            : (_carList.isEmpty || _dataTableCells.isEmpty)
                ? const Center(
                    child: Text('No car'),
                  )
                : CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      tab('All Cars', false),
                                      tab('Expiry less than one month', true),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color.fromARGB(
                                          204, 240, 224, 83),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Create Car',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                      SliverFillRemaining(
                        child: DataTable(
                          columns: _dataColumns(),
                          rows: _dataRows(),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
