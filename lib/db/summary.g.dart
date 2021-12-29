// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class summaryAdapter extends TypeAdapter<summary> {
  @override
  final int typeId = 0;

  @override
  summary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return summary(
      name: fields[0] as String,
      background: fields[1] as String,
      head: fields[2] as String,
      rating: fields[3] as double,
      type: (fields[4] as List).cast<String>(),
      view: fields[5] as int,
      trailer: fields[6] as String,
      director: (fields[7] as List).cast<String>(),
      actor: (fields[8] as List).cast<String>(),
      description: fields[9] as String,
      full: fields[10] as String,
      buy: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, summary obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.background)
      ..writeByte(2)
      ..write(obj.head)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.view)
      ..writeByte(6)
      ..write(obj.trailer)
      ..writeByte(7)
      ..write(obj.director)
      ..writeByte(8)
      ..write(obj.actor)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(10)
      ..write(obj.full)
      ..writeByte(11)
      ..write(obj.buy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is summaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
