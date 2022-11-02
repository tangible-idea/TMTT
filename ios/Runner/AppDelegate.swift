import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
          let batteryChannel = FlutterMethodChannel(name: "link.tmtt/shareinsta",
                                                    binaryMessenger: controller.binaryMessenger)
          batteryChannel.setMethodCallHandler({
              [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
                // Note: this method is invoked on the UI thread.
                guard call.method == "shareInstagramImageStoryWithSticker" else {
                  result(FlutterMethodNotImplemented)
                  return
                }
              self?.shareOnInstagram(call: call, result: result)
              
              
          })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func shareOnInstagram(call: FlutterMethodCall, result: FlutterResult) {
//        //Sharing story on instagram
//        let stickerImage:String! = call.arguments["stickerImage"]
//        let backgroundTopColor:String! = call.arguments["backgroundTopColor"]
//        let backgroundBottomColor:String! = call.arguments["backgroundBottomColor"]
//        let attributionURL:String! = call.arguments["attributionURL"]
//        let backgroundImage:String! = call.arguments["backgroundImage"]
//        //getting image from file
//        let fileManager:NSFileManager! = NSFileManager.defaultManager()
//        let isFileExist:Bool = fileManager.fileExistsAtPath(stickerImage)
//        var imgShare:UIImage!
        
        let device = UIDevice.current
          device.isBatteryMonitoringEnabled = true
          if device.batteryState == UIDevice.BatteryState.unknown {
              result("TMTT methodchannel test from IOS native.")
//            result(FlutterError(code: "UNAVAILABLE",
//                                message: "Battery info unavailable",
//                                details: nil))
          } else {
            result(Int(device.batteryLevel * 100))
          }
    }

}
