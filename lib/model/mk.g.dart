// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mk.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterkeyAdapter extends TypeAdapter<Masterkey> {
  @override
  final int typeId = 2;

  @override
  Masterkey read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Masterkey(
      AppName: fields[0] as String,
      masterkey: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Masterkey obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.AppName)
      ..writeByte(1)
      ..write(obj.masterkey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasterkeyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
