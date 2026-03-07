import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../popups/loaders.dart';

class NetworkManager extends GetxController
{
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  final Rx<ConnectivityResult> _connectionStatus =
      ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // Update connection status based on changes in connectivity and show a relevant popup for no internet Connection.
  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    if (results.contains(ConnectivityResult.none)) {
      _connectionStatus.value = ConnectivityResult.none;
      AppLoaders.customToast(message: "No Internet Connection");
    } else {
      _connectionStatus.value = results.first;
    }
  }

  // Check internet connection status.
  Future<bool> isConnected() async {
    try {
      final List<ConnectivityResult> results = await _connectivity.checkConnectivity();

      if (results.contains(ConnectivityResult.none) || results.isEmpty)
      {
        return false;
      }
      else
        {
          return true;
        }

    } on PlatformException
    {
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}