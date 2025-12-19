import UIKit
import Flutter
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    FirebaseApp.configure()
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let appInfoChannel = FlutterMethodChannel(name: "app_info_channel",
                                              binaryMessenger: controller.binaryMessenger)
    
    appInfoChannel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      switch call.method {
      case "getInstalledApps":
        self?.getInstalledApps(result: result)
      default:
        result(FlutterMethodNotImplemented)
      }
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func getInstalledApps(result: @escaping FlutterResult) {
    // iOS has severe restrictions on getting installed apps
    // We can only get basic info about our own app
    
    let bundle = Bundle.main
    
    let appName = bundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
                 ?? bundle.object(forInfoDictionaryKey: "CFBundleName") as? String
                 ?? "Unknown"
    let bundleId = bundle.bundleIdentifier ?? "unknown.bundle.id"
    let version = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
    
    // Get app install time (creation date of app bundle)
    let installTime: Int64
    let bundlePath = bundle.bundlePath
    do {
      let attributes = try FileManager.default.attributesOfItem(atPath: bundlePath)
      if let creationDate = attributes[.creationDate] as? Date {
        installTime = Int64(creationDate.timeIntervalSince1970 * 1000) // Convert to milliseconds
      } else {
        installTime = Int64(Date().timeIntervalSince1970 * 1000)
      }
    } catch {
      installTime = Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    let appInfo: [String: Any] = [
      "name": appName,
      "packageName": bundleId,
      "version": version,
      "installTime": installTime
    ]
    
    result([appInfo])
  }
}
