import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/location_filter_model.dart';
import 'package:flutter/material.dart';

class LocationFilterNotifier with ChangeNotifier {
  LocationFilterModel? locationFilterModel;
  bool loading = false;

  int _page = 1;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  List<LocationFilterData> _locationFilterList = <LocationFilterData>[];

  final List<LocationFilterData> _locationAllList = <LocationFilterData>[];

  List<LocationFilterData> get locationFilterList => _locationFilterList;

  set locationData(List<LocationFilterData> value) {
    _locationFilterList = value.cast<LocationFilterData>();
  }

  Future<void> fetchLocationFilterData(String regionId) async {
    loading = true;
    notifyListeners();
    await getLocationFilterData(regionId).then((value) {
      if (_locationFilterList.isNotEmpty) {
        _locationFilterList.clear();
      }
      addLocationToList(value!.data);
    });
    loading = false;
    notifyListeners();
  }

  void addLocationToList(List<LocationFilterData>? locationList) {
    _locationFilterList.addAll(locationList!);
    _locationAllList.addAll(locationList);
    notifyListeners();
  }

  void search(String search) {
    if (search.isEmpty) {
      _locationFilterList.clear();
      _locationFilterList.addAll(_locationAllList);
    } else {
      _locationFilterList.clear();
      // ignore: avoid_function_literals_in_foreach_calls
      _locationAllList.forEach((data) {
        if (data.title!.toLowerCase().contains(search.toLowerCase())) {
          _locationFilterList.add(data);
        }
      });
    }
    notifyListeners();
  }
}
