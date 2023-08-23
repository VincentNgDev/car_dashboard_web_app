class VehicleModel {
  String carPlateNum;
  String color;
  String propellant;
  String seatNum;
  String expiryDate;

  VehicleModel({
    required this.carPlateNum,
    required this.color,
    required this.propellant,
    required this.seatNum,
    required this.expiryDate,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      carPlateNum: json['car_plate_number'] ?? '',
      color: json['color'] ?? '',
      propellant: json['propellant'] ?? '',
      seatNum: json['number_of_seat'] ?? '',
      expiryDate: json['expiry_date'] ?? '',
    );
  }

  Map<String, String> toJson() {
    return {
      'car_plate_number' : carPlateNum,
      'color' : color,
      'propellant' : propellant,
      'number_of_seat' : seatNum.toString(),
      'expiry_date' : expiryDate,
    };
  }

  @override
  String toString() {
    return 'Vehicle(plateNum: $carPlateNum, color: $color, propellant: $propellant, seat: $seatNum, expiry: $expiryDate)';
  }
}
