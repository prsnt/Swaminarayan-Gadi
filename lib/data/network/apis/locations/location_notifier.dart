import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/location_data_model.dart';
import 'package:flutter/material.dart';

class LocationNotifier with ChangeNotifier {
  LocationDataModel? locationDataModel;
  bool loading = false;
  bool isLoadMoreItem = false;
  int _page = 1;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  List<LocationData> _locationList = <LocationData>[];

  final List<LocationData> _locationAllList = <LocationData>[];

  List<LocationData> get locationList => _locationList;

  set locationData(List<LocationDataModel> value) {
    _locationList = value.cast<LocationData>();
  }

  Future<void> fetchLocationData(bool isFilter, bool isLoadMore) async {
    if (isLoadMore) {
      isLoadMoreItem = true;
      notifyListeners();
    } else {
      loading = true;
      notifyListeners();
    }
    if (isFilter) {
      _page = 1;
      if (_locationList.isNotEmpty) {
        _locationList.clear();
        _locationAllList.clear();
      }
    }
    await getLocationData(_page).then((value) {
      _page = _page + 1;
      addLocationToList(value!.mainData!.data);
    });
    if (isLoadMore) {
      isLoadMoreItem = false;
    } else {
      loading = false;
    }
    notifyListeners();
  }

  void addLocationToList(List<LocationData>? locationList) {
    _locationList.addAll(locationList!);
    _locationAllList.addAll(locationList);
    notifyListeners();
  }

  void search(String search) {
    if (search.isEmpty) {
      _locationList.clear();
      _locationList.addAll(_locationAllList);
    } else {
      _locationList.clear();
      for (final data in _locationAllList) {
        if (data.title!.toLowerCase().contains(search.toLowerCase())) {
          _locationList.add(data);
        }
      }
    }
    notifyListeners();
  }
}
