import UIKit
import Flutter
import AVKit
import GoogleMaps
import Firebase
import FirebaseCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "payment_launch",
                                                      binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({
              (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in

        guard call.method == "online" else {
            result(FlutterMethodNotImplemented)
            return
        }
        self.receiveBatteryLevel(result: result, url: call.arguments as! String)
        })

    if #available(iOS 10.0, *) {
       UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    GMSServices.provideAPIKey("AIzaSyAif82vLTmiXCk126nJVidRZMaRCEOEc2g")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    private func receiveBatteryLevel(result: FlutterResult, url: String) {
        let paymentUrl = URL(string: url)!
        if UIApplication.shared.canOpenURL(paymentUrl)
          {
              result(1)
              UIApplication.shared.open(paymentUrl)
          } else {
              result(2)
              UIApplication.shared.open(URL(string: url)!)
          }
      }
}
