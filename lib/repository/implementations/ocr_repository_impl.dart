import 'package:flutter/foundation.dart';
import 'package:padelgo/constants/end_point.dart';
import 'package:padelgo/models/face_recog.dart';
import 'package:padelgo/models/liveness_check.dart';
import 'package:padelgo/models/liveness_license_entity.dart';
import 'package:padelgo/models/ocr.dart';
import 'package:padelgo/repository/base/helpers.dart';
import 'package:padelgo/repository/base/rest_api_repository_base.dart';
import 'package:padelgo/repository/interfaces/ocr_repository.dart';
import 'package:padelgo/helpers/preference_helper.dart';

class OcrRepositoryImpl extends RestApiRepositoryBase implements OcrRepository {
  OcrRepositoryImpl({super.base});

  @override
  Future<LivenessLicenseEntity?> getLivenessLicense() async {
    try {
      return await GetHelper<LivenessLicenseEntity>().getCommon(() async {
        return await post(EndPoint.ocrToken, {});
      }, (responseData) {
        return LivenessLicenseEntity.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch liveness license: $e');
      }
      rethrow;
    }
  }

  @override
  Future<Ocr?> performOcrCheck(String base64Image) async {
    try {
      Map<String, dynamic> data = {
        "imageBase64": base64Image,
      };

      if (kDebugMode) {
        print('Performing OCR check with data: ${data.keys}');
      }

      return await GetHelper<Ocr>().getCommon(() async {
        final response = await post(EndPoint.ocrCheck, data);

        if (kDebugMode) {
          print('Raw OCR API response: $response');
        }
        if (response is Map<String, dynamic> &&
            response.containsKey('message')) {
          response['msg'] = response['message'];
        }

        return response;
      }, (responseData) {
        if (kDebugMode) {
          print('OCR API responseData after GetHelper: $responseData');
        }

        return Ocr.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to perform OCR check: $e');
      }
      rethrow;
    }
  }

  @override
  Future<LivenessCheck?> livenessCheck(String id, int userId) async {
    try {
      final result = await GetHelper<LivenessCheck>().getCommon(() async {
        return await post(EndPoint.livenessCheck, {
          "livenessId": id,
          "userId": userId,
        });
      }, (responseData) {
        return LivenessCheck.fromJson(responseData);
      });

      if (result != null) {
        if (result.livenessScore != null) {
          await PkPreferenceHelper.saveLivenessScore(result.livenessScore!);
        }

        if (result.detectionResult != null &&
            result.detectionResult!.isNotEmpty) {
          await PkPreferenceHelper.saveLivenessDetectionResult(
              result.detectionResult!);
        }
      }

      return result;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed liveness check: $e');
      }
      rethrow;
    }
  }

  @override
  Future<FaceRecog?> faceComparison(
      String faceImage, String idCardImage) async {
    try {
      return await GetHelper<FaceRecog>().getCommon(() async {
        return await post(EndPoint.faceRecog, {
          "faceImageBase64": faceImage,
          "idCardImageBase64": idCardImage,
        });
      }, (responseData) {
        return FaceRecog.fromJson(responseData);
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed face recognition data: $e');
      }
      rethrow;
    }
  }
}
