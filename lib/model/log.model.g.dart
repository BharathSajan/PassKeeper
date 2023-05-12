// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class logModelAdapter extends TypeAdapter<logModel> {
  @override
  final int typeId = 1;

  @override
  logModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return logModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, logModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.dateTm)
      ..writeByte(1)
      ..write(obj.domainTm)
      ..writeByte(2)
      ..write(obj.usernameTm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is logModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
