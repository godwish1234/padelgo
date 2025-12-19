import 'package:flutter/foundation.dart';

typedef ResponseBuilder<T> = Future<dynamic> Function();
typedef ConvertJson<T, S> = T Function(S);

class GetHelper<T> {
  Future<T?> getCommon(ResponseBuilder<T> builder,
      ConvertJson<T, Map<String, dynamic>> convertJson) async {
    try {
      dynamic response = await builder();

      if (response is Map<String, dynamic>) {
        final adjustedData = _adjustMap(response);
        if (adjustedData != null) {
          return convertJson(adjustedData);
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('GetHelper error: $e');
      }
      rethrow;
    }
    return null;
  }

  Future<List<T>?> getListCommon<T>(ResponseBuilder<List<T>> builder,
      T Function(Map<String, dynamic>) itemFromJson) async {
    try {
      dynamic response = await builder();

      if (response is Map<String, dynamic>) {
        final adjustedData = _adjustMap(response);
        if (adjustedData != null) {
          final dataList = adjustedData['data'] as List<dynamic>?;
          if (dataList != null) {
            return dataList
                .map((item) => itemFromJson(item as Map<String, dynamic>))
                .toList();
          }
          return <T>[];
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('GetHelper error: $e');
      }
      rethrow;
    }
    return null;
  }

  static Map<String, dynamic>? _adjustMap(Map<String, dynamic>? data) {
    if (data != null) {
      try {
        if ((data.containsKey("success") || data.containsKey("code")) &&
            data.containsKey("data")) {
          final dataField = data["data"];

          if (dataField is Map<String, dynamic> &&
              (dataField.containsKey("religions") ||
                  dataField.containsKey("educationLevels") ||
                  dataField.containsKey("workExperiences") ||
                  dataField.containsKey("workTypes"))) {
            return data;
          }

          if (dataField is Map<String, dynamic>) {
            final extractedData = dataField;
            if (data.containsKey("code") &&
                !extractedData.containsKey("code_p")) {
              extractedData["code_p"] = data["code"].toString();
            }
            if (data.containsKey("msg") &&
                !extractedData.containsKey("msg_p")) {
              extractedData["msg_p"] = data["msg"];
            }
            if (data.containsKey("trace_id") &&
                !extractedData.containsKey("trace_id")) {
              extractedData["trace_id"] = data["trace_id"];
            }
            if (data.containsKey("traceId") &&
                !extractedData.containsKey("traceId")) {
              extractedData["traceId"] = data["traceId"];
            }
            if (data.containsKey("timestamp") &&
                !extractedData.containsKey("timestamp")) {
              extractedData["timestamp"] = data["timestamp"];
            }
            if (data.containsKey("success") &&
                !extractedData.containsKey("success")) {
              extractedData["success"] = data["success"];
            }

            return extractedData;
          }

          final wrapperData = Map<String, dynamic>.from(data);

          if (!wrapperData.containsKey("code_p")) {
            wrapperData["code_p"] = data["code"]?.toString();
          }
          if (!wrapperData.containsKey("msg_p")) {
            wrapperData["msg_p"] = data["msg"];
          }

          return wrapperData;
        }

        return data;
      } catch (e) {
        if (kDebugMode) {
          print('Error adjusting map: $e');
        }
      }
    }
    return null;
  }
}
