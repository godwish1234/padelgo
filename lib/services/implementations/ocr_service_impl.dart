import 'package:padelgo/models/face_recog.dart';
import 'package:padelgo/models/liveness_check.dart';
import 'package:padelgo/models/liveness_license_entity.dart';
import 'package:padelgo/models/ocr.dart';
import 'package:padelgo/repository/implementations/ocr_repository_impl.dart';
import 'package:padelgo/repository/interfaces/ocr_repository.dart';
import 'package:padelgo/services/interfaces/ocr_service.dart';

class OcrServiceImpl implements OcrService {
  final OcrRepository _ocrRepository = OcrRepositoryImpl();

  @override
  Future<LivenessLicenseEntity?> getLivenessLicense() async {
    return await _ocrRepository.getLivenessLicense();
  }

  @override
  Future<Ocr?> performOcrCheck(String base64Image) async {
    return await _ocrRepository.performOcrCheck(base64Image);
  }

  @override
  Future<LivenessCheck?> livenessCheck(String id, int userId) async {
    return await _ocrRepository.livenessCheck(id, userId);
  }

  @override
  Future<FaceRecog?> faceComparison(
      String faceImage, String idCardImage) async {
    return await _ocrRepository.faceComparison(faceImage, idCardImage);
  }
}
