// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'employee_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$EmployeeStateTearOff {
  const _$EmployeeStateTearOff();

  EmployeeInitial initial() {
    return const EmployeeInitial();
  }

  EmployeeLoading loading() {
    return const EmployeeLoading();
  }

  EmployeeError error(Failure failure) {
    return EmployeeError(
      failure,
    );
  }

  EmployeeSuccess employeeSuccess(List<Employee> employeeDaya) {
    return EmployeeSuccess(
      employeeDaya,
    );
  }
}

/// @nodoc
const $EmployeeState = _$EmployeeStateTearOff();

/// @nodoc
mixin _$EmployeeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Failure failure) error,
    required TResult Function(List<Employee> employeeDaya) employeeSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Failure failure)? error,
    TResult Function(List<Employee> employeeDaya)? employeeSuccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeInitial value) initial,
    required TResult Function(EmployeeLoading value) loading,
    required TResult Function(EmployeeError value) error,
    required TResult Function(EmployeeSuccess value) employeeSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeInitial value)? initial,
    TResult Function(EmployeeLoading value)? loading,
    TResult Function(EmployeeError value)? error,
    TResult Function(EmployeeSuccess value)? employeeSuccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeStateCopyWith<$Res> {
  factory $EmployeeStateCopyWith(
          EmployeeState value, $Res Function(EmployeeState) then) =
      _$EmployeeStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$EmployeeStateCopyWithImpl<$Res>
    implements $EmployeeStateCopyWith<$Res> {
  _$EmployeeStateCopyWithImpl(this._value, this._then);

  final EmployeeState _value;
  // ignore: unused_field
  final $Res Function(EmployeeState) _then;
}

/// @nodoc
abstract class $EmployeeInitialCopyWith<$Res> {
  factory $EmployeeInitialCopyWith(
          EmployeeInitial value, $Res Function(EmployeeInitial) then) =
      _$EmployeeInitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$EmployeeInitialCopyWithImpl<$Res>
    extends _$EmployeeStateCopyWithImpl<$Res>
    implements $EmployeeInitialCopyWith<$Res> {
  _$EmployeeInitialCopyWithImpl(
      EmployeeInitial _value, $Res Function(EmployeeInitial) _then)
      : super(_value, (v) => _then(v as EmployeeInitial));

  @override
  EmployeeInitial get _value => super._value as EmployeeInitial;
}

/// @nodoc

class _$EmployeeInitial implements EmployeeInitial {
  const _$EmployeeInitial();

  @override
  String toString() {
    return 'EmployeeState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is EmployeeInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Failure failure) error,
    required TResult Function(List<Employee> employeeDaya) employeeSuccess,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Failure failure)? error,
    TResult Function(List<Employee> employeeDaya)? employeeSuccess,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeInitial value) initial,
    required TResult Function(EmployeeLoading value) loading,
    required TResult Function(EmployeeError value) error,
    required TResult Function(EmployeeSuccess value) employeeSuccess,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeInitial value)? initial,
    TResult Function(EmployeeLoading value)? loading,
    TResult Function(EmployeeError value)? error,
    TResult Function(EmployeeSuccess value)? employeeSuccess,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class EmployeeInitial implements EmployeeState {
  const factory EmployeeInitial() = _$EmployeeInitial;
}

/// @nodoc
abstract class $EmployeeLoadingCopyWith<$Res> {
  factory $EmployeeLoadingCopyWith(
          EmployeeLoading value, $Res Function(EmployeeLoading) then) =
      _$EmployeeLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$EmployeeLoadingCopyWithImpl<$Res>
    extends _$EmployeeStateCopyWithImpl<$Res>
    implements $EmployeeLoadingCopyWith<$Res> {
  _$EmployeeLoadingCopyWithImpl(
      EmployeeLoading _value, $Res Function(EmployeeLoading) _then)
      : super(_value, (v) => _then(v as EmployeeLoading));

  @override
  EmployeeLoading get _value => super._value as EmployeeLoading;
}

/// @nodoc

class _$EmployeeLoading implements EmployeeLoading {
  const _$EmployeeLoading();

  @override
  String toString() {
    return 'EmployeeState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is EmployeeLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Failure failure) error,
    required TResult Function(List<Employee> employeeDaya) employeeSuccess,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Failure failure)? error,
    TResult Function(List<Employee> employeeDaya)? employeeSuccess,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeInitial value) initial,
    required TResult Function(EmployeeLoading value) loading,
    required TResult Function(EmployeeError value) error,
    required TResult Function(EmployeeSuccess value) employeeSuccess,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeInitial value)? initial,
    TResult Function(EmployeeLoading value)? loading,
    TResult Function(EmployeeError value)? error,
    TResult Function(EmployeeSuccess value)? employeeSuccess,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class EmployeeLoading implements EmployeeState {
  const factory EmployeeLoading() = _$EmployeeLoading;
}

/// @nodoc
abstract class $EmployeeErrorCopyWith<$Res> {
  factory $EmployeeErrorCopyWith(
          EmployeeError value, $Res Function(EmployeeError) then) =
      _$EmployeeErrorCopyWithImpl<$Res>;
  $Res call({Failure failure});
}

/// @nodoc
class _$EmployeeErrorCopyWithImpl<$Res>
    extends _$EmployeeStateCopyWithImpl<$Res>
    implements $EmployeeErrorCopyWith<$Res> {
  _$EmployeeErrorCopyWithImpl(
      EmployeeError _value, $Res Function(EmployeeError) _then)
      : super(_value, (v) => _then(v as EmployeeError));

  @override
  EmployeeError get _value => super._value as EmployeeError;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(EmployeeError(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }
}

/// @nodoc

class _$EmployeeError implements EmployeeError {
  const _$EmployeeError(this.failure);

  @override
  final Failure failure;

  @override
  String toString() {
    return 'EmployeeState.error(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EmployeeError &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  $EmployeeErrorCopyWith<EmployeeError> get copyWith =>
      _$EmployeeErrorCopyWithImpl<EmployeeError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Failure failure) error,
    required TResult Function(List<Employee> employeeDaya) employeeSuccess,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Failure failure)? error,
    TResult Function(List<Employee> employeeDaya)? employeeSuccess,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeInitial value) initial,
    required TResult Function(EmployeeLoading value) loading,
    required TResult Function(EmployeeError value) error,
    required TResult Function(EmployeeSuccess value) employeeSuccess,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeInitial value)? initial,
    TResult Function(EmployeeLoading value)? loading,
    TResult Function(EmployeeError value)? error,
    TResult Function(EmployeeSuccess value)? employeeSuccess,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class EmployeeError implements EmployeeState {
  const factory EmployeeError(Failure failure) = _$EmployeeError;

  Failure get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeErrorCopyWith<EmployeeError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeSuccessCopyWith<$Res> {
  factory $EmployeeSuccessCopyWith(
          EmployeeSuccess value, $Res Function(EmployeeSuccess) then) =
      _$EmployeeSuccessCopyWithImpl<$Res>;
  $Res call({List<Employee> employeeDaya});
}

/// @nodoc
class _$EmployeeSuccessCopyWithImpl<$Res>
    extends _$EmployeeStateCopyWithImpl<$Res>
    implements $EmployeeSuccessCopyWith<$Res> {
  _$EmployeeSuccessCopyWithImpl(
      EmployeeSuccess _value, $Res Function(EmployeeSuccess) _then)
      : super(_value, (v) => _then(v as EmployeeSuccess));

  @override
  EmployeeSuccess get _value => super._value as EmployeeSuccess;

  @override
  $Res call({
    Object? employeeDaya = freezed,
  }) {
    return _then(EmployeeSuccess(
      employeeDaya == freezed
          ? _value.employeeDaya
          : employeeDaya // ignore: cast_nullable_to_non_nullable
              as List<Employee>,
    ));
  }
}

/// @nodoc

class _$EmployeeSuccess implements EmployeeSuccess {
  const _$EmployeeSuccess(this.employeeDaya);

  @override
  final List<Employee> employeeDaya;

  @override
  String toString() {
    return 'EmployeeState.employeeSuccess(employeeDaya: $employeeDaya)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EmployeeSuccess &&
            (identical(other.employeeDaya, employeeDaya) ||
                const DeepCollectionEquality()
                    .equals(other.employeeDaya, employeeDaya)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(employeeDaya);

  @JsonKey(ignore: true)
  @override
  $EmployeeSuccessCopyWith<EmployeeSuccess> get copyWith =>
      _$EmployeeSuccessCopyWithImpl<EmployeeSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Failure failure) error,
    required TResult Function(List<Employee> employeeDaya) employeeSuccess,
  }) {
    return employeeSuccess(employeeDaya);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Failure failure)? error,
    TResult Function(List<Employee> employeeDaya)? employeeSuccess,
    required TResult orElse(),
  }) {
    if (employeeSuccess != null) {
      return employeeSuccess(employeeDaya);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeInitial value) initial,
    required TResult Function(EmployeeLoading value) loading,
    required TResult Function(EmployeeError value) error,
    required TResult Function(EmployeeSuccess value) employeeSuccess,
  }) {
    return employeeSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeInitial value)? initial,
    TResult Function(EmployeeLoading value)? loading,
    TResult Function(EmployeeError value)? error,
    TResult Function(EmployeeSuccess value)? employeeSuccess,
    required TResult orElse(),
  }) {
    if (employeeSuccess != null) {
      return employeeSuccess(this);
    }
    return orElse();
  }
}

abstract class EmployeeSuccess implements EmployeeState {
  const factory EmployeeSuccess(List<Employee> employeeDaya) =
      _$EmployeeSuccess;

  List<Employee> get employeeDaya => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeSuccessCopyWith<EmployeeSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}
