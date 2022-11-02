import UIKit
import Flutter
import Firebase

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

    #if DEBUG
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
    #endif
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func shareOnInstagram(call: FlutterMethodCall, result: FlutterResult) {
//        //Sharing story on instagram
//        let stickerImage: String! = call.arguments["imagePath"]
//        let backgroundTopColor: String! = call.arguments["backgroundTopColor"]
//        let backgroundBottomColor: String! = call.arguments["backgroundBottomColor"]
//        let attributionURL: String! = call.arguments["attributionURL"]
//        let backgroundImage: String! = call.arguments["backgroundImage"]
//        //getting image from file
//        let fileManager: FileManager! = FileManager.default
//        let isFileExist: Bool = fileManager.fileExists(atPath: stickerImage)
//        var imgShare: UIImage!
//
//        if isFileExist {
//            //if image exists
//            imgShare = UIImage(contentsOfFile: stickerImage)
//        }
//
//        //url Scheme for instagram story
//        let urlScheme: URL! = URL.URLWithString("instagram-stories://share")
//
//        //adding data to send to instagram story
//        if UIApplication.shared.canOpenURL(urlScheme) {
//            //if instagram is installed and the url can be opened
//            if backgroundImage.count == 0 {
//                //If you dont have a background image
//                // Assign background image asset and attribution link URL to pasteboard
//                let pasteboardItems: NSArray = [["com.instagram.sharedSticker.stickerImage": imgShare, "com.instagram.sharedSticker.backgroundTopColor": backgroundTopColor, "com.instagram.sharedSticker.backgroundBottomColor": backgroundBottomColor, "com.instagram.sharedSticker.contentURL": attributionURL]]
//
//                if available() {
//                    let pasteboardOptions: NSDictionary! = [UIPasteboardOptionExpirationDate: Date().addingTimeInterval(60 * 5)]
//
//                    // This call is iOS 10+, can use 'setItems' depending on what versions you support
//                    UIPasteboard.generalPasteboard().setItems(pasteboardItems, options: pasteboardOptions)
//                    UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
//                    //if success
//                    result("sharing")
//                } else {
//                    result("this only supports iOS 10+")
//                }
//            } else {
//                //if you have a background image
//                let fileManager: FileManager! = FileManager.default
//                let isFileExist: Bool = fileManager.fileExists(atPath: backgroundImage)
//                var imgBackgroundShare: UIImage!
//
//                if isFileExist {
//                    imgBackgroundShare = UIImage(contentsOfFile: backgroundImage)
//                }
//
//                let pasteboardItems: NSArray = [["com.instagram.sharedSticker.backgroundImage": imgBackgroundShare, "com.instagram.sharedSticker.stickerImage": imgShare, "com.instagram.sharedSticker.backgroundTopColor": backgroundTopColor, "com.instagram.sharedSticker.backgroundBottomColor": backgroundBottomColor, "com.instagram.sharedSticker.contentURL": attributionURL]]
//
//                //if available() {
//                let pasteboardOptions: NSDictionary! = [UIPasteboardOption.expirationDate: Date().addingTimeInterval(60 * 5)]
//
//                    // This call is iOS 10+, can use 'setItems' depending on what versions you support
//                    UIPasteboard.generalPasteboard().setItems(pasteboardItems, options: pasteboardOptions)
//                    UIApplication.sharedApplication().openURL(urlScheme, options: [:], completionHandler: nil)
//                    result("sharing")
////                } else {
////                    result("this only supports iOS 10+")
////                }
//            }
//        } else {
//            result("not supported or no facebook installed")
//        }

        
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
