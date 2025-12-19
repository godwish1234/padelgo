import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpers {
  static String formatNumberWithSeparator(int number) {
    final formatter = NumberFormat('#,##0', 'id_ID');
    return formatter.format(number).replaceAll(',', '.');
  }

  static String formatDate(int? timestamp) {
    if (timestamp == null) return '';
    try {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    } catch (e) {
      debugPrint('Error formatting date: $e');
      return '';
    }
  }

  static String formatDate2(String? date) {
    if (date == null) return '';
    DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date);
    return DateFormat("dd-MM-yyyy").format(parsedDate);
  }

  static String formatToDate(int? timestamp) {
    if (timestamp == null) return '';
    try {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static String formatToDate2(int? timestamp) {
    if (timestamp == null) return '';
    try {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static String formatToTime(int? timestamp) {
    if (timestamp == null) return '';
    try {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return DateFormat('HH:mm').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  int? convertBirthdayToTimestamp(String? birthday) {
    if (birthday == null) return null;

    final date = DateFormat("yyyy/MM/dd").parse(birthday);

    return date.millisecondsSinceEpoch ~/ 1000;
  }

  String getStatusText(int status) {
    switch (status) {
      case 1:
        return 'Belum Dicairkan';
      case 2:
        return 'Verifikasi Gagal';
      case 3:
        return 'Pencairan Gagal';
      case 4:
        return 'Pencairan Gagal';
      case 5:
        return 'Telah Dicairkan';
      case 6:
        return 'Lunas';
      case 7:
        return 'Keterlambatan';
      case 8:
        return 'Dalam Pencairan';
      case 9:
        return 'Pengajuan Dibatalkan';
      default:
        return 'Unknown';
    }
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.black;
      case 2:
        return Colors.red;
      case 3:
        return Colors.red;
      case 4:
        return Colors.red;
      case 5:
        return Colors.black;
      case 6:
        return Colors.green;
      case 7:
        return Colors.red;
      case 8:
        return Colors.black;
      case 9:
        return Colors.black;
      default:
        return Colors.black;
    }
  }

  bool getButtonIcon(int status) {
    switch (status) {
      case 1:
        return true;
      case 2:
        return false;
      case 3:
        return false;
      case 4:
        return false;
      case 5:
        return true;
      case 6:
        return true;
      case 7:
        return true;
      case 8:
        return true;
      case 9:
        return false;
      default:
        return false;
    }
  }

  String formatPhoneNumberWithVisibleEnds(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return '+62';
    }

    // If phone number is 6 or fewer chars, just show it all
    if (phoneNumber.length <= 6) {
      return '+62 $phoneNumber';
    }

    // Show first 4 digits
    String firstPart = phoneNumber.substring(0, 4);

    // Mask middle digits with asterisks
    int middleLength = phoneNumber.length - 6; // 4 first + 2 last = 6
    String middlePart = '*' * (middleLength > 0 ? middleLength : 0);

    // Show last 2 digits
    String lastPart = phoneNumber.substring(phoneNumber.length - 2);

    return '+62 $firstPart$middlePart$lastPart';
  }

  Future<void> openUrlWithLogging(String url, String orderNumber) async {
    final Uri uri = Uri.parse(url);

    try {
      // Try Chrome first
      final chromeUrl =
          Uri.parse('googlechrome://navigate?url=${uri.toString()}');
      if (await canLaunchUrl(chromeUrl)) {
        await launchUrl(chromeUrl);
      } else {
        // Fall back to default browser
        if (await canLaunchUrl(uri)) {
          await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );
        }
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  static void openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  static void openPhoneCall(String phoneNumber) => _openApp('tel:$phoneNumber');

  static void openWhatsApp(String whatsApp) {
    String cleanNumber = whatsApp.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanNumber.startsWith('0')) {
      cleanNumber = '62${cleanNumber.substring(1)}';
    } else if (!cleanNumber.startsWith('62')) {
      cleanNumber = '62$cleanNumber';
    }

    _openApp('https://wa.me/$cleanNumber');
  }

  static void openMail(String email) async => _openApp('mailto:$email');

  static void openApp(String android, String ios) async =>
      _openApp(Platform.isAndroid ? android : ios);

  static Future<void> _openApp(String value) async {
    final Uri uri = Uri.parse(value);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Error launching URL: $value');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  static String formatAccountNumber(String? value) {
    if (value == null) return '';
    return '*' * (value.length - 4) + value.substring(value.length - 4);
  }

  static String formatCurrency(dynamic value) {
    if (value == null) return '0';
    return NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0)
        .format(value is String ? int.tryParse(value) ?? 0 : value);
  }

  static String formatCurrencyUnit(dynamic value) =>
      'Rp ${formatCurrency(value)}';

  static void clipboard(String value, String message) =>
      Clipboard.setData(ClipboardData(text: value)).then((value) =>
          Fluttertoast.showToast(
              backgroundColor: Colors.black,
              textColor: Colors.white,
              msg: message));

  static String formatPercentage(dynamic value) {
    try {
      final parsed = double.parse(value.toString().replaceAll(',', '.'));
      String formattedValue = parsed.toString();

      if (!formattedValue.contains('.')) {
        formattedValue = '$formattedValue.0';
      }

      return '${formattedValue.replaceAll('.', ',')}%';
    } catch (e) {
      return '0%';
    }
  }

  static String maskPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return '0';
    }

    String phone = phoneNumber.startsWith('0') ? phoneNumber : '0$phoneNumber';

    if (phone.length <= 11) {
      if (phone.length <= 6) {
        return phone;
      }
      String start = phone.substring(0, 3);
      String end = phone.substring(phone.length - 4);
      return '$start****$end';
    } else {
      if (phone.length <= 6) {
        return phone;
      }
      int startLength = 4;
      String start = phone.substring(0, startLength);
      String end = phone.substring(startLength + 4);
      return '$start****$end';
    }
  }
}
