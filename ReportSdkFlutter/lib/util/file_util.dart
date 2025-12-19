import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtil{

  static Future<Directory?> _getReportDirectory() async{
    Directory supportDirectory = await getApplicationSupportDirectory();
    if(null == supportDirectory){
      return null;
    }
    Directory reportDirectory = Directory(supportDirectory.path + "/datac");
    if(!reportDirectory.existsSync()){
      reportDirectory.createSync();
    }
    return reportDirectory;
  }

  static Future<File?> getReportFile() async{
    Directory? reportDirectory = await _getReportDirectory();
    if(null == reportDirectory){
      return null;
    }
    File file = File(reportDirectory.path + "/datac.json");
    if(!file.existsSync()){
      file.createSync();
    }
    return file;
  }

  static Future<String?> getReportString() async{
    File? file = await getReportFile();
    if(file == null || file.lengthSync() == 0){
      return null;
    }
    String data = file.readAsStringSync();
    file.deleteSync();
    return data;
  }

  static Future revertContent(String datas) async{
    File? file = await getReportFile();
    if(file == null){
      return null;
    }
    file.writeAsStringSync(datas, flush: true, mode:  FileMode.writeOnlyAppend);
  }

  static Future<int> getUploadFileSize() async{
    File? file = await getReportFile();
    if(file == null){
      return 0;
    }
    return file.lengthSync();
  }

  static Future deleteReportFile() async{
    File? file = await getReportFile();
    if(file == null){
      return;
    }
    file.deleteSync();
  }

  static Future<int> saveStringToJson(String jsonStr) async{
    File? file = await getReportFile();
    if(file == null){
      return 0;
    }
    file.writeAsStringSync((file.lengthSync() > 0 ? "\n" : "") + jsonStr, mode:  FileMode.writeOnlyAppend, flush: true);
    return file.lengthSync();
  }

}