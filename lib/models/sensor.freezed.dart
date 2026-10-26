// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Sensor {

 String get id; String get nom; double get temperature; int get humidite; bool get enLigne; int get batterie; String get etat; String get derniereMesure;
/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SensorCopyWith<Sensor> get copyWith => _$SensorCopyWithImpl<Sensor>(this as Sensor, _$identity);

  /// Serializes this Sensor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Sensor;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Sensor&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nom, _this.nom) || other.nom == _this.nom)&&(identical(other.temperature, _this.temperature) || other.temperature == _this.temperature)&&(identical(other.humidite, _this.humidite) || other.humidite == _this.humidite)&&(identical(other.enLigne, _this.enLigne) || other.enLigne == _this.enLigne)&&(identical(other.batterie, _this.batterie) || other.batterie == _this.batterie)&&(identical(other.etat, _this.etat) || other.etat == _this.etat)&&(identical(other.derniereMesure, _this.derniereMesure) || other.derniereMesure == _this.derniereMesure));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Sensor;
  return Object.hash(runtimeType,_this.id,_this.nom,_this.temperature,_this.humidite,_this.enLigne,_this.batterie,_this.etat,_this.derniereMesure);
}

@override
String toString() {
  final _this = this as Sensor;
  return 'Sensor(id: ${_this.id}, nom: ${_this.nom}, temperature: ${_this.temperature}, humidite: ${_this.humidite}, enLigne: ${_this.enLigne}, batterie: ${_this.batterie}, etat: ${_this.etat}, derniereMesure: ${_this.derniereMesure})';
}


}

/// @nodoc
abstract mixin class $SensorCopyWith<$Res>  {
  factory $SensorCopyWith(Sensor value, $Res Function(Sensor) _then) = _$SensorCopyWithImpl;
@useResult
$Res call({
 String id, String nom, double temperature, int humidite, bool enLigne, int batterie, String etat, String derniereMesure
});




}
/// @nodoc
class _$SensorCopyWithImpl<$Res>
    implements $SensorCopyWith<$Res> {
  _$SensorCopyWithImpl(this._self, this._then);

  final Sensor _self;
  final $Res Function(Sensor) _then;

/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? temperature = null,Object? humidite = null,Object? enLigne = null,Object? batterie = null,Object? etat = null,Object? derniereMesure = null,}) {
  return _then(Sensor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,humidite: null == humidite ? _self.humidite : humidite // ignore: cast_nullable_to_non_nullable
as int,enLigne: null == enLigne ? _self.enLigne : enLigne // ignore: cast_nullable_to_non_nullable
as bool,batterie: null == batterie ? _self.batterie : batterie // ignore: cast_nullable_to_non_nullable
as int,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,derniereMesure: null == derniereMesure ? _self.derniereMesure : derniereMesure // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Sensor].
extension SensorPatterns on Sensor {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Sensor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Sensor() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Sensor value)  $default,){
final _that = this;
switch (_that) {
case _Sensor():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Sensor value)?  $default,){
final _that = this;
switch (_that) {
case _Sensor() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nom,  double temperature,  int humidite,  bool enLigne,  int batterie,  String etat,  String derniereMesure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Sensor() when $default != null:
return $default(_that.id,_that.nom,_that.temperature,_that.humidite,_that.enLigne,_that.batterie,_that.etat,_that.derniereMesure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nom,  double temperature,  int humidite,  bool enLigne,  int batterie,  String etat,  String derniereMesure)  $default,) {final _that = this;
switch (_that) {
case _Sensor():
return $default(_that.id,_that.nom,_that.temperature,_that.humidite,_that.enLigne,_that.batterie,_that.etat,_that.derniereMesure);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nom,  double temperature,  int humidite,  bool enLigne,  int batterie,  String etat,  String derniereMesure)?  $default,) {final _that = this;
switch (_that) {
case _Sensor() when $default != null:
return $default(_that.id,_that.nom,_that.temperature,_that.humidite,_that.enLigne,_that.batterie,_that.etat,_that.derniereMesure);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Sensor implements Sensor {
  const _Sensor({required this.id, required this.nom, required this.temperature, required this.humidite, required this.enLigne, required this.batterie, required this.etat, required this.derniereMesure});
  factory _Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);

@override final  String id;
@override final  String nom;
@override final  double temperature;
@override final  int humidite;
@override final  bool enLigne;
@override final  int batterie;
@override final  String etat;
@override final  String derniereMesure;

/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SensorCopyWith<_Sensor> get copyWith => __$SensorCopyWithImpl<_Sensor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SensorToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Sensor&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.humidite, humidite) || other.humidite == humidite)&&(identical(other.enLigne, enLigne) || other.enLigne == enLigne)&&(identical(other.batterie, batterie) || other.batterie == batterie)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.derniereMesure, derniereMesure) || other.derniereMesure == derniereMesure));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nom,temperature,humidite,enLigne,batterie,etat,derniereMesure);
}

@override
String toString() {
    return 'Sensor(id: $id, nom: $nom, temperature: $temperature, humidite: $humidite, enLigne: $enLigne, batterie: $batterie, etat: $etat, derniereMesure: $derniereMesure)';
}


}

/// @nodoc
abstract mixin class _$SensorCopyWith<$Res> implements $SensorCopyWith<$Res> {
  factory _$SensorCopyWith(_Sensor value, $Res Function(_Sensor) _then) = __$SensorCopyWithImpl;
@override @useResult
$Res call({
 String id, String nom, double temperature, int humidite, bool enLigne, int batterie, String etat, String derniereMesure
});




}
/// @nodoc
class __$SensorCopyWithImpl<$Res>
    implements _$SensorCopyWith<$Res> {
  __$SensorCopyWithImpl(this._self, this._then);

  final _Sensor _self;
  final $Res Function(_Sensor) _then;

/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? temperature = null,Object? humidite = null,Object? enLigne = null,Object? batterie = null,Object? etat = null,Object? derniereMesure = null,}) {
  return _then(_Sensor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,humidite: null == humidite ? _self.humidite : humidite // ignore: cast_nullable_to_non_nullable
as int,enLigne: null == enLigne ? _self.enLigne : enLigne // ignore: cast_nullable_to_non_nullable
as bool,batterie: null == batterie ? _self.batterie : batterie // ignore: cast_nullable_to_non_nullable
as int,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,derniereMesure: null == derniereMesure ? _self.derniereMesure : derniereMesure // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
