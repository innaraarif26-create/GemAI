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

    // Listen to connectivity changes
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(
              (List<ConnectivityResult> results) {
            _updateConnectionStatus(results);
          },
        );
  }

  // Update connection status
  Future<void> _updateConnectionStatus(
      List<ConnectivityResult> results) async {

    ConnectivityResult result = ConnectivityResult.none;

    if (results.contains(ConnectivityResult.wifi)) {
      result = ConnectivityResult.wifi;
    } else if (results.contains(ConnectivityResult.mobile)) {
      result = ConnectivityResult.mobile;
    } else if (results.contains(ConnectivityResult.ethernet)) {
      result = ConnectivityResult.ethernet;
    } else if (results.contains(ConnectivityResult.vpn)) {
      result = ConnectivityResult.vpn;
    }

    _connectionStatus.value = result;

    if (result == ConnectivityResult.none) {
      AppLoaders.warningSnackBar(
        title: "No Internet Connection",
        message: "Please check your internet connection.",
      );
    }
  }

  // Check internet manually
  Future<bool> isConnected() async {
    try {
      final List<ConnectivityResult> results =
      await _connectivity.checkConnectivity();

      if (results.contains(ConnectivityResult.none) ||
          results.isEmpty) {
        return false;
      }

      return true;
    } on PlatformException catch (_) {
      return false;
    }
  }

  ConnectivityResult get connectionStatus =>
      _connectionStatus.value;

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}