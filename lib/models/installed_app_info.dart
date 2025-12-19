class InstalledAppInfo {
  InstalledAppInfo({
      String name = '',
      String package = '',
      String version = '',
      String installtime = '',
      String lastUpdateTime = '',}){
    _name = name;
    _package = package;
    _version = version;
    _installtime = installtime;
    _lastUpdateTime = lastUpdateTime;
}

  InstalledAppInfo.fromJson(dynamic json) {
    _name = json['name'];
    _package = json['package'];
    _version = json['version'];
    _installtime = json['installtime'];
    _lastUpdateTime = json['last_update_time'];
  }
  String _name = '';
  String _package = '';
  String _version = '';
  String _installtime = '';
  String _lastUpdateTime = '';
InstalledAppInfo copyWith({  String name = '',
  String package = '',
  String version = '',
  String installtime = '',
  String lastUpdateTime = '',
}) => InstalledAppInfo(  name: name,
  package: package,
  version: version,
  installtime: installtime,
  lastUpdateTime: lastUpdateTime,
);
  String get name => _name;
  String get package => _package;
  String get version => _version;
  String get installtime => _installtime;
  String get lastUpdateTime => _lastUpdateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['package'] = _package;
    map['version'] = _version;
    map['installtime'] = _installtime;
    map['last_update_time'] = _lastUpdateTime;
    return map;
  }

}