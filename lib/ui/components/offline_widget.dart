import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:padelgo/constants/constant.dart';
import 'package:padelgo/ui/base/base_button.dart';

class OfflineWidget extends StatefulWidget {
  const OfflineWidget({super.key});

  @override
  State<OfflineWidget> createState() => _OfflineWidgetState();
}

class _OfflineWidgetState extends State<OfflineWidget> {
  bool _isLoading = false;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) async {
      if (results.isNotEmpty && !results.contains(ConnectivityResult.none)) {
        if (kDebugMode) {
          print("OfflineWidget: Connection restored, going back");
        }
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final connectivityResults = await Connectivity().checkConnectivity();

      if (connectivityResults.isNotEmpty &&
          !connectivityResults.contains(ConnectivityResult.none)) {
        if (kDebugMode) {
          print("OfflineWidget: Connection available, going back");
        }
        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Masih tidak ada koneksi. Periksa pengaturan jaringan Anda.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("OfflineWidget: Error checking connectivity: $e");
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal memeriksa koneksi. Coba lagi.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                size: 120,
                color: Colors.grey[400],
              ),
              const SizedBox(
                height: BaseSizes.baseGapMedium,
              ),
              const Text(
                'Tidak Ada Koneksi Internet',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff333333),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: BaseSizes.baseGapSmall,
              ),
              const Text(
                'Pastikan Wi-Fi atau data seluler Anda aktif, lalu coba lagi.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff888888),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: BaseSizes.baseGapXLarge,
              ),
              Row(
                children: [
                  Expanded(
                    child: BaseButton(
                      isLoading: _isLoading,
                      text: 'Coba Lagi',
                      enabled: !_isLoading,
                      onPressed: _checkConnectivity,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
