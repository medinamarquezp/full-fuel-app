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
      latitude: fields[3] as double,
      longitude: fields[4] as double,
      isNowOpen: fields[5] as bool,
      fuelPrices: (fields[6] as List)?.cast<FuelPriceEntity>(),
      brandImage: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FuelstationListEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.fuelstationID)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.distance)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.isNowOpen)
      ..writeByte(6)
      ..write(obj.fuelPrices)
      ..writeByte(7)
      ..write(obj.brandImage);
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
