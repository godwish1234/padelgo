import 'package:padelgo/models/face_recog.dart';
import 'package:padelgo/models/liveness_check.dart';
import 'package:padelgo/models/liveness_license_entity.dart';
import 'package:padelgo/models/ocr.dart';

abstract class OcrService {
  Future<LivenessLicenseEntity?> getLivenessLicense();
  Future<Ocr?> performOcrCheck(String base64Image);
  Future<LivenessCheck?> livenessCheck(String id, int userId);
  Future<FaceRecog?> faceComparison(String faceImage, String idCardImage);
}
