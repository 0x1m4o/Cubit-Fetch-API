// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserResponseAdapter extends TypeAdapter<UserResponse> {
  @override
  final int typeId = 1;

  @override
  UserResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserResponse(
      fullname: fields[0] as String,
      city: fields[1] as String,
      country: fields[2] as String,
      instagram: fields[3] as String,
      about: fields[4] as String,
      facebook: fields[5] as String,
      twitter: fields[6] as String,
      job: fields[7] as String,
      avatar: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserResponse obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.fullname)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.instagram)
      ..writeByte(4)
      ..write(obj.about)
      ..writeByte(5)
      ..write(obj.facebook)
      ..writeByte(6)
      ..write(obj.twitter)
      ..writeByte(7)
      ..write(obj.job)
      ..writeByte(8)
      ..write(obj.avatar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
