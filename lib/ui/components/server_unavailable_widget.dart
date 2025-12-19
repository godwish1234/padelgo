import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:padelgo/constants/constant.dart';
import 'package:padelgo/ui/base/base_button.dart';

class ServerUnavailableWidget extends StatefulWidget {
  const ServerUnavailableWidget({super.key});

  @override
  State<ServerUnavailableWidget> createState() =>
      _ServerUnavailableWidgetState();
}

class _ServerUnavailableWidgetState extends State<ServerUnavailableWidget> {
  bool _isLoading = false;

  Future<void> _retry() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (kDebugMode) {
        print("ServerUnavailableWidget: Error during retry: $e");
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal mencoba kembali. Silakan coba lagi.'),
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
                Icons.cloud_off_outlined,
                size: 120,
                color: Colors.orange[400],
              ),
              const SizedBox(
                height: BaseSizes.baseGapMedium,
              ),
              const Text(
                'Server Tidak Tersedia',
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
                'Server sedang mengalami gangguan atau dalam pemeliharaan. Silakan coba lagi dalam beberapa saat.',
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
                      onPressed: _retry,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
