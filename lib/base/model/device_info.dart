class DeviceInfo {
  DeviceInfo({
      String? filesDirPath, 
      String? wifiAssistantDns, 
      String? availableMemory, 
      String? batteryLevel, 
      String? batteryTemperature, 
      String? bootTime, 
      String? builderHost, 
      num? chargeStatus, 
      String? checkSystemByPath, 
      String? checkSystemByUserService, 
      String? cpuFramework, 
      String? cpuMaxFrequency, 
      String? cpuModel, 
      String? wifiGateWay, 
      String? firmwareNo, 
      String? kernelVersion, 
      String? wifiMainDns, 
      String? wifiNetMask, 
      String? builderTag, 
      String? screenBrightness, 
      String? deviceResolution, 
      num? stepNum, 
      String? systemInitializeId, 
      String? timeZone, 
      String? totalMemory, 
      String? wifiBssid, 
      String? wifiIp, 
      String? wifiMacAddress, 
      String? wifiName, 
      String? totalRam, 
      String? currentRam, 
      String? totalRom, 
      String? currentRom, 
      String? totalBootedTime, 
      String? currentBatteryLevel, 
      String? currentUsbStatus, 
      String? channel,
      int? isRoot,
      int? isEmulator,
      String? country, 
      String? os, 
      String? appVersion, 
      String? ns, 
      String? gaid, 
      String? tz, 
      String? fcmRegId, 
      String? version, 
      String? dfp, 
      String? authorization, 
      String? v, 
      String? lan, 
      String? model, 
      String? androidId, 
      String? brand, 
      String? aid, 
      String? timestamp, 
      String? uid,}){
    _filesDirPath = filesDirPath;
    _wifiAssistantDns = wifiAssistantDns;
    _availableMemory = availableMemory;
    _batteryLevel = batteryLevel;
    _batteryTemperature = batteryTemperature;
    _bootTime = bootTime;
    _builderHost = builderHost;
    _chargeStatus = chargeStatus;
    _checkSystemByPath = checkSystemByPath;
    _checkSystemByUserService = checkSystemByUserService;
    _cpuFramework = cpuFramework;
    _cpuMaxFrequency = cpuMaxFrequency;
    _cpuModel = cpuModel;
    _wifiGateWay = wifiGateWay;
    _firmwareNo = firmwareNo;
    _kernelVersion = kernelVersion;
    _wifiMainDns = wifiMainDns;
    _wifiNetMask = wifiNetMask;
    _builderTag = builderTag;
    _screenBrightness = screenBrightness;
    _deviceResolution = deviceResolution;
    _stepNum = stepNum;
    _systemInitializeId = systemInitializeId;
    _timeZone = timeZone;
    _totalMemory = totalMemory;
    _wifiBssid = wifiBssid;
    _wifiIp = wifiIp;
    _wifiMacAddress = wifiMacAddress;
    _wifiName = wifiName;
    _totalRam = totalRam;
    _currentRam = currentRam;
    _totalRom = totalRom;
    _currentRom = currentRom;
    _totalBootedTime = totalBootedTime;
    _currentBatteryLevel = currentBatteryLevel;
    _currentUsbStatus = currentUsbStatus;
    _channel = channel;
    _isRoot = isRoot;
    _isEmulator = isEmulator;
    _country = country;
    _os = os;
    _appVersion = appVersion;
    _ns = ns;
    _gaid = gaid;
    _tz = tz;
    _fcmRegId = fcmRegId;
    _version = version;
    _dfp = dfp;
    _authorization = authorization;
    _v = v;
    _lan = lan;
    _model = model;
    _androidId = androidId;
    _brand = brand;
    _aid = aid;
    _timestamp = timestamp;
    _uid = uid;
}

  DeviceInfo.fromJson(dynamic json) {
    _filesDirPath = json['files_dir_path'];
    _wifiAssistantDns = json['wifi_assistant_dns'];
    _availableMemory = json['available_memory'];
    _batteryLevel = json['battery_level'];
    _batteryTemperature = json['battery_temperature'];
    _bootTime = json['boot_time'];
    _builderHost = json['builder_host'];
    _chargeStatus = json['charge_status'];
    _checkSystemByPath = json['check_system_by_path'];
    _checkSystemByUserService = json['check_system_by_user_service'];
    _cpuFramework = json['cpu_framework'];
    _cpuMaxFrequency = json['cpu_max_frequency'];
    _cpuModel = json['cpu_model'];
    _wifiGateWay = json['wifi_gate_way'];
    _firmwareNo = json['firmware_no'];
    _kernelVersion = json['kernel_version'];
    _wifiMainDns = json['wifi_main_dns'];
    _wifiNetMask = json['wifi_net_mask'];
    _builderTag = json['builder_tag'];
    _screenBrightness = json['screen_brightness'];
    _deviceResolution = json['device_resolution'];
    _stepNum = json['step_num'];
    _systemInitializeId = json['system_initialize_id'];
    _timeZone = json['time_zone'];
    _totalMemory = json['total_memory'];
    _wifiBssid = json['wifi_bssid'];
    _wifiIp = json['wifi_ip'];
    _wifiMacAddress = json['wifi_mac_address'];
    _wifiName = json['wifi_name'];
    _totalRam = json['total_ram'];
    _currentRam = json['current_ram'];
    _totalRom = json['total_rom'];
    _currentRom = json['current_rom'];
    _totalBootedTime = json['total_booted_time'];
    _currentBatteryLevel = json['current_battery_level'];
    _currentUsbStatus = json['current_usb_status'];
    _channel = json['channel'];
    _isRoot = json['is_root'];
    _isEmulator = json['is_emulator'];
    _country = json['country'];
    _os = json['os'];
    _appVersion = json['app_version'];
    _ns = json['ns'];
    _gaid = json['gaid'];
    _tz = json['tz'];
    _fcmRegId = json['fcm_reg_id'];
    _version = json['version'];
    _dfp = json['dfp'];
    _authorization = json['authorization'];
    _v = json['v'];
    _lan = json['lan'];
    _model = json['model'];
    _androidId = json['android_id'];
    _brand = json['brand'];
    _aid = json['aid'];
    _timestamp = json['timestamp'];
    _uid = json['uid'];
  }
  String? _filesDirPath;
  String? _wifiAssistantDns;
  String? _availableMemory;
  String? _batteryLevel;
  String? _batteryTemperature;
  String? _bootTime;
  String? _builderHost;
  num? _chargeStatus;
  String? _checkSystemByPath;
  String? _checkSystemByUserService;
  String? _cpuFramework;
  String? _cpuMaxFrequency;
  String? _cpuModel;
  String? _wifiGateWay;
  String? _firmwareNo;
  String? _kernelVersion;
  String? _wifiMainDns;
  String? _wifiNetMask;
  String? _builderTag;
  String? _screenBrightness;
  String? _deviceResolution;
  num? _stepNum;
  String? _systemInitializeId;
  String? _timeZone;
  String? _totalMemory;
  String? _wifiBssid;
  String? _wifiIp;
  String? _wifiMacAddress;
  String? _wifiName;
  String? _totalRam;
  String? _currentRam;
  String? _totalRom;
  String? _currentRom;
  String? _totalBootedTime;
  String? _currentBatteryLevel;
  String? _currentUsbStatus;
  String? _channel;
  int? _isRoot;
  int? _isEmulator;
  String? _country;
  String? _os;
  String? _appVersion;
  String? _ns;
  String? _gaid;
  String? _tz;
  String? _fcmRegId;
  String? _version;
  String? _dfp;
  String? _authorization;
  String? _v;
  String? _lan;
  String? _model;
  String? _androidId;
  String? _brand;
  String? _aid;
  String? _timestamp;
  String? _uid;
DeviceInfo copyWith({  String? filesDirPath,
  String? wifiAssistantDns,
  String? availableMemory,
  String? batteryLevel,
  String? batteryTemperature,
  String? bootTime,
  String? builderHost,
  num? chargeStatus,
  String? checkSystemByPath,
  String? checkSystemByUserService,
  String? cpuFramework,
  String? cpuMaxFrequency,
  String? cpuModel,
  String? wifiGateWay,
  String? firmwareNo,
  String? kernelVersion,
  String? wifiMainDns,
  String? wifiNetMask,
  String? builderTag,
  String? screenBrightness,
  String? deviceResolution,
  num? stepNum,
  String? systemInitializeId,
  String? timeZone,
  String? totalMemory,
  String? wifiBssid,
  String? wifiIp,
  String? wifiMacAddress,
  String? wifiName,
  String? totalRam,
  String? currentRam,
  String? totalRom,
  String? currentRom,
  String? totalBootedTime,
  String? currentBatteryLevel,
  String? currentUsbStatus,
  String? channel,
  int? isRoot,
  int? isEmulator,
  String? country,
  String? os,
  String? appVersion,
  String? ns,
  String? gaid,
  String? tz,
  String? fcmRegId,
  String? version,
  String? dfp,
  String? authorization,
  String? v,
  String? lan,
  String? model,
  String? androidId,
  String? brand,
  String? aid,
  String? timestamp,
  String? uid,
}) => DeviceInfo(  filesDirPath: filesDirPath ?? _filesDirPath,
  wifiAssistantDns: wifiAssistantDns ?? _wifiAssistantDns,
  availableMemory: availableMemory ?? _availableMemory,
  batteryLevel: batteryLevel ?? _batteryLevel,
  batteryTemperature: batteryTemperature ?? _batteryTemperature,
  bootTime: bootTime ?? _bootTime,
  builderHost: builderHost ?? _builderHost,
  chargeStatus: chargeStatus ?? _chargeStatus,
  checkSystemByPath: checkSystemByPath ?? _checkSystemByPath,
  checkSystemByUserService: checkSystemByUserService ?? _checkSystemByUserService,
  cpuFramework: cpuFramework ?? _cpuFramework,
  cpuMaxFrequency: cpuMaxFrequency ?? _cpuMaxFrequency,
  cpuModel: cpuModel ?? _cpuModel,
  wifiGateWay: wifiGateWay ?? _wifiGateWay,
  firmwareNo: firmwareNo ?? _firmwareNo,
  kernelVersion: kernelVersion ?? _kernelVersion,
  wifiMainDns: wifiMainDns ?? _wifiMainDns,
  wifiNetMask: wifiNetMask ?? _wifiNetMask,
  builderTag: builderTag ?? _builderTag,
  screenBrightness: screenBrightness ?? _screenBrightness,
  deviceResolution: deviceResolution ?? _deviceResolution,
  stepNum: stepNum ?? _stepNum,
  systemInitializeId: systemInitializeId ?? _systemInitializeId,
  timeZone: timeZone ?? _timeZone,
  totalMemory: totalMemory ?? _totalMemory,
  wifiBssid: wifiBssid ?? _wifiBssid,
  wifiIp: wifiIp ?? _wifiIp,
  wifiMacAddress: wifiMacAddress ?? _wifiMacAddress,
  wifiName: wifiName ?? _wifiName,
  totalRam: totalRam ?? _totalRam,
  currentRam: currentRam ?? _currentRam,
  totalRom: totalRom ?? _totalRom,
  currentRom: currentRom ?? _currentRom,
  totalBootedTime: totalBootedTime ?? _totalBootedTime,
  currentBatteryLevel: currentBatteryLevel ?? _currentBatteryLevel,
  currentUsbStatus: currentUsbStatus ?? _currentUsbStatus,
  channel: channel ?? _channel,
  isRoot: isRoot ?? _isRoot,
  isEmulator: isEmulator ?? _isEmulator,
  country: country ?? _country,
  os: os ?? _os,
  appVersion: appVersion ?? _appVersion,
  ns: ns ?? _ns,
  gaid: gaid ?? _gaid,
  tz: tz ?? _tz,
  fcmRegId: fcmRegId ?? _fcmRegId,
  version: version ?? _version,
  dfp: dfp ?? _dfp,
  authorization: authorization ?? _authorization,
  v: v ?? _v,
  lan: lan ?? _lan,
  model: model ?? _model,
  androidId: androidId ?? _androidId,
  brand: brand ?? _brand,
  aid: aid ?? _aid,
  timestamp: timestamp ?? _timestamp,
  uid: uid ?? _uid,
);


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if(_filesDirPath != null){
      map['files_dir_path'] = _filesDirPath;
    }
    if(_wifiAssistantDns != null){
      map['wifi_assistant_dns'] = _wifiAssistantDns;
    }
    if(_availableMemory != null){
      map['available_memory'] = _availableMemory;
    }
    if(_batteryLevel != null){
      map['battery_level'] = _batteryLevel;
    }

    if(_batteryTemperature != null){
      map['battery_temperature'] = _batteryTemperature;
    }
    if(_bootTime != null){
      map['boot_time'] = _bootTime;
    }
    if(_builderHost != null){
      map['builder_host'] = _builderHost;
    }
    if(_chargeStatus != null){
      map['charge_status'] = _chargeStatus;
    }

    if(_checkSystemByPath != null){
      map['check_system_by_path'] = _checkSystemByPath;
    }
    if(_checkSystemByUserService != null){
      map['check_system_by_user_service'] = _checkSystemByUserService;
    }
    if(_cpuFramework != null){
      map['cpu_framework'] = _cpuFramework;
    }
    if(_cpuMaxFrequency != null){
      map['cpu_max_frequency'] = _cpuMaxFrequency;
    }

    if(_cpuModel != null){
      map['cpu_model'] = _cpuModel;
    }
    if(_wifiGateWay != null){
      map['wifi_gate_way'] = _wifiGateWay;
    }
    if(_firmwareNo != null){
      map['firmware_no'] = _firmwareNo;
    }
    if(_kernelVersion != null){
      map['kernel_version'] = _kernelVersion;
    }

    if(_wifiMainDns != null){
      map['wifi_main_dns'] = _wifiMainDns;
    }
    if(_wifiNetMask != null){
      map['wifi_net_mask'] = _wifiNetMask;
    }
    if(_builderTag != null){
      map['builder_tag'] = _builderTag;
    }
    if(_screenBrightness != null){
      map['screen_brightness'] = _screenBrightness;
    }

    if(_deviceResolution != null){
      map['device_resolution'] = _deviceResolution;
    }
    if(_stepNum != null){
      map['step_num'] = _stepNum;
    }
    if(_builderTag != null){
      map['builder_tag'] = _builderTag;
    }
    if(_screenBrightness != null){
      map['screen_brightness'] = _screenBrightness;
    }



    map['system_initialize_id'] = _systemInitializeId;
    map['time_zone'] = _timeZone;
    map['total_memory'] = _totalMemory;
    map['wifi_bssid'] = _wifiBssid;
    map['wifi_ip'] = _wifiIp;
    map['wifi_mac_address'] = _wifiMacAddress;
    map['wifi_name'] = _wifiName;
    map['total_ram'] = _totalRam;
    map['current_ram'] = _currentRam;
    map['total_rom'] = _totalRom;
    map['current_rom'] = _currentRom;
    map['total_booted_time'] = _totalBootedTime;
    map['current_battery_level'] = _currentBatteryLevel;
    map['current_usb_status'] = _currentUsbStatus;
    map['channel'] = _channel;
    map['is_root'] = _isRoot;
    map['is_emulator'] = _isEmulator;
    map['country'] = _country;
    map['os'] = _os;
    map['app_version'] = _appVersion;
    map['ns'] = _ns;
    map['gaid'] = _gaid;
    map['tz'] = _tz;
    map['fcm_reg_id'] = _fcmRegId;
    map['version'] = _version;
    map['dfp'] = _dfp;
    map['authorization'] = _authorization;
    map['v'] = _v;
    map['lan'] = _lan;
    map['model'] = _model;
    map['android_id'] = _androidId;
    map['brand'] = _brand;
    map['aid'] = _aid;
    map['timestamp'] = _timestamp;
    map['uid'] = _uid;
    return map;
  }

  set uid(String value) {
    _uid = value;
  }

  set timestamp(String value) {
    _timestamp = value;
  }

  set aid(String value) {
    _aid = value;
  }

  set brand(String value) {
    _brand = value;
  }

  set androidId(String value) {
    _androidId = value;
  }

  set model(String value) {
    _model = value;
  }

  set lan(String value) {
    _lan = value;
  }

  set v(String value) {
    _v = value;
  }

  set authorization(String value) {
    _authorization = value;
  }

  set dfp(String value) {
    _dfp = value;
  }

  set version(String value) {
    _version = value;
  }

  set fcmRegId(String value) {
    _fcmRegId = value;
  }

  set tz(String value) {
    _tz = value;
  }

  set gaid(String value) {
    _gaid = value;
  }

  set ns(String value) {
    _ns = value;
  }

  set appVersion(String value) {
    _appVersion = value;
  }

  set os(String value) {
    _os = value;
  }

  set country(String value) {
    _country = value;
  }

  set isEmulator(int value) {
    _isEmulator = value;
  }

  set isRoot(int value) {
    _isRoot = value;
  }

  set channel(String value) {
    _channel = value;
  }

  set currentUsbStatus(String value) {
    _currentUsbStatus = value;
  }

  set currentBatteryLevel(String value) {
    _currentBatteryLevel = value;
  }

  set totalBootedTime(String value) {
    _totalBootedTime = value;
  }

  set currentRom(String value) {
    _currentRom = value;
  }

  set totalRom(String value) {
    _totalRom = value;
  }

  set currentRam(String value) {
    _currentRam = value;
  }

  set totalRam(String value) {
    _totalRam = value;
  }

  set wifiName(String value) {
    _wifiName = value;
  }

  set wifiMacAddress(String value) {
    _wifiMacAddress = value;
  }

  set wifiIp(String value) {
    _wifiIp = value;
  }

  set wifiBssid(String value) {
    _wifiBssid = value;
  }

  set totalMemory(String value) {
    _totalMemory = value;
  }

  set timeZone(String value) {
    _timeZone = value;
  }

  set systemInitializeId(String value) {
    _systemInitializeId = value;
  }

  set stepNum(num value) {
    _stepNum = value;
  }

  set deviceResolution(String value) {
    _deviceResolution = value;
  }

  set screenBrightness(String value) {
    _screenBrightness = value;
  }

  set builderTag(String value) {
    _builderTag = value;
  }

  set wifiNetMask(String value) {
    _wifiNetMask = value;
  }

  set wifiMainDns(String value) {
    _wifiMainDns = value;
  }

  set kernelVersion(String value) {
    _kernelVersion = value;
  }

  set firmwareNo(String value) {
    _firmwareNo = value;
  }

  set wifiGateWay(String value) {
    _wifiGateWay = value;
  }

  set cpuModel(String value) {
    _cpuModel = value;
  }

  set cpuMaxFrequency(String value) {
    _cpuMaxFrequency = value;
  }

  set cpuFramework(String value) {
    _cpuFramework = value;
  }

  set checkSystemByUserService(String value) {
    _checkSystemByUserService = value;
  }

  set checkSystemByPath(String value) {
    _checkSystemByPath = value;
  }

  set chargeStatus(num value) {
    _chargeStatus = value;
  }

  set builderHost(String value) {
    _builderHost = value;
  }

  set bootTime(String value) {
    _bootTime = value;
  }

  set batteryTemperature(String value) {
    _batteryTemperature = value;
  }

  set batteryLevel(String value) {
    _batteryLevel = value;
  }

  set availableMemory(String value) {
    _availableMemory = value;
  }

  set wifiAssistantDns(String value) {
    _wifiAssistantDns = value;
  }

  set filesDirPath(String value) {
    _filesDirPath = value;
  }


}