// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_json_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoredJSONAdapter extends TypeAdapter<StoredJSON> {
  @override
  final int typeId = 1;

  @override
  StoredJSON read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoredJSON(
      timeStamp: fields[0] as DateTime,
      json: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StoredJSON obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.timeStamp)
      ..writeByte(1)
      ..write(obj.json);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoredJSONAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
