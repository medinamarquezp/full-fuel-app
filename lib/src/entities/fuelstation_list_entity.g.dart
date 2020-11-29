// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuelstation_list_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FuelstationListEntityAdapter extends TypeAdapter<FuelstationListEntity> {
  @override
  final int typeId = 0;

  @override
  FuelstationListEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FuelstationListEntity(
      fuelstationID: fields[0] as int,
      name: fields[1] as String,
      distance: fields[2] as double,
      isNowOpen: fields[3] as bool,
      fuelPrices: (fields[4] as List)?.cast<FuelPrice>(),
    );
  }

  @override
  void write(BinaryWriter writer, FuelstationListEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.fuelstationID)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.distance)
      ..writeByte(3)
      ..write(obj.isNowOpen)
      ..writeByte(4)
      ..write(obj.fuelPrices);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FuelstationListEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
