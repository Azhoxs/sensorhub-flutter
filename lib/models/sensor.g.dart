// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Sensor _$SensorFromJson(Map<String, dynamic> json) => _Sensor(
  id: json['id'] as String,
  nom: json['nom'] as String,
  temperature: (json['temperature'] as num).toDouble(),
  humidite: (json['humidite'] as num).toInt(),
  enLigne: json['enLigne'] as bool,
  batterie: (json['batterie'] as num).toInt(),
  etat: json['etat'] as String,
  derniereMesure: json['derniereMesure'] as String,
);

Map<String, dynamic> _$SensorToJson(_Sensor instance) => <String, dynamic>{
  'id': instance.id,
  'nom': instance.nom,
  'temperature': instance.temperature,
  'humidite': instance.humidite,
  'enLigne': instance.enLigne,
  'batterie': instance.batterie,
  'etat': instance.etat,
  'derniereMesure': instance.derniereMesure,
};
