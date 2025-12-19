import 'package:padelgo/models/upload_device_response.dart';

abstract class StartupService {
  Future<UploadDeviceResponse?> uploadDeviceInfo();
}
