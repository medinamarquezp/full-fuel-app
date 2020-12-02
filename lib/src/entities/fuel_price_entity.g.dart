// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_price_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FuelPriceEntityAdapter extends TypeAdapter<FuelPriceEntity> {
  @override
  final int typeId = 1;

  @override
  FuelPriceEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FuelPriceEntity(
      fields[0] as String,
      fields[1] as double,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FuelPriceEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.fuelType)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.evolution);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FuelPriceEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
