import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:ffi';  // For FFI
import 'dart:io';   // For Platform.isX
import 'package:ffi/ffi.dart';

class Coordinate extends Struct {
  @Double()
  double latitude;

  @Double()
  double longitude;

  factory Coordinate.allocate(double latitude, double longitude) =>
      allocate<Coordinate>().ref
        ..latitude = latitude
        ..longitude = longitude;
}

typedef create_coordinate_func = Pointer<Coordinate> Function(
    Double latitude, Double longitude);
typedef CreateCoordinate = Pointer<Coordinate> Function(
    double latitude, double longitude);

final DynamicLibrary nativeAddLib =
  Platform.isAndroid
    ? DynamicLibrary.open("libnative_add.so")
    : DynamicLibrary.process();

final int Function(int x, int y) nativeAdd =
  nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
    .asFunction();

int summOfElements(List<int> list) {
  Pointer<Int32> arr = allocate<Int32>(count: list.length);
  for (int i = 0; i < list.length; i++) {
    arr[i] = list[i];
  }
  return _summOfElements(arr, list.length);
}

final int Function(Pointer<Int32> arr, int size) _summOfElements =
  nativeAddLib
    .lookup<NativeFunction<Int32 Function(Pointer<Int32>, Int32)>>("sum_of_elements")
    .asFunction();

    // sum_of_elements

  final createCoordinatePointer =
      nativeAddLib.lookup<NativeFunction<create_coordinate_func>>('create_coordinate');
  final createCoordinate =
      createCoordinatePointer.asFunction<CreateCoordinate>();
// final Pointer<Coordinate> Function(int x, int y) nativeCoordinates =
//   nativeAddLib
//     .lookup<NativeFunction<Pointer<Coordinate> Function(Int32, Int32)>>("create_coordinate")
//     .asFunction();

// final createCoordinatePointer =
//       nativeAddLib.lookup<NativeFunction<create_coordinate_func>>('create_coordinate');
//   final createCoordinate =
//       createCoordinatePointer.asFunction<CreateCoordinate>();


// class NativeAdd {
//   static const MethodChannel _channel =
//       const MethodChannel('native_add');

//   static Future<String> get platformVersion async {
//     final String version = await _channel.invokeMethod('getPlatformVersion');
//     return version;
//   }
// }
