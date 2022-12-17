import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    

    var tempA = "";
    //var isNeedCopyOnBackground = false;
    
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
              
              if(call.method == "shareInstagramImageStoryWithSticker") {
                  //self?.isNeedCopyOnBackground = true;
                  self?.shareOnInstagram(call: call, result: result)
              }else{
                  //self?.isNeedCopyOnBackground = false;
              }
              
              
          })

    #if DEBUG
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
    #endif
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    
    // 백그라운드로 가는 시점.
    override func applicationDidEnterBackground(_ application: UIApplication) {
        //applicationLifeCycleChannel.sendMessage("applicationDidEnterBackground")
        //UIPasteboard.general.string = tempA
        
        // read from clipboard
//        let content = UIPasteboard.general.string ?? ""
//        if(content.contains("tmtt.link")) {
//            print("link is already in your clipboard: " + content)
//            return
//        }

        if(UIPasteboard.general.hasStrings == false) {
            print("applicationDidEnterBackground::my link::" + tempA)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.015) {
                print("0.015 seconds there")
                // 0.015초 후 실행될 부분
                UIPasteboard.general.string = self.tempA
            }
        }
        
    }
    
    private func shareOnInstagram(call: FlutterMethodCall, result: FlutterResult) {

        let args = call.arguments as? Dictionary<String, Any>
        guard let args = args else { return }
        
        //Sharing story on instagram
        let stickerImage = args["imagePath"] as? String
        let linkToShare = args["link"] as? String
        let backgroundTopColor = "#000000"
        let backgroundBottomColor = "#000000"
        let attributionURL = linkToShare
        //let backgroundImage = args["backgroundImage"] as? String
        
        guard let stickerImage = stickerImage else {
            result("this only supports iOS 10+")
            return
        }
        // getting image from file
        let fileManager: FileManager! = FileManager.default
        let isFileExist: Bool = fileManager.fileExists(atPath: stickerImage)
        if !isFileExist {
            return
        }
        
        guard let imgShare = UIImage(contentsOfFile: stickerImage) else { return }
        
        //url Scheme for instagram story
        guard let urlScheme = URL(string: "instagram-stories://share") else {
            result("this only supports iOS 10+")
            return
        }
       
        if !UIApplication.shared.canOpenURL(urlScheme) {
            result("not supported or no facebook installed")
            return
        }
 
        //If you dont have a background image
        // Assign background image asset and attribution link URL to pasteboard
        let pasteboardItems = [
            [
//                 "com.instagram.sharedSticker.stickerImage": imgShare,
                "com.instagram.sharedSticker.backgroundTopColor": backgroundTopColor,
                "com.instagram.sharedSticker.backgroundBottomColor": backgroundBottomColor,
                "com.instagram.sharedSticker.contentURL": attributionURL,
                "com.instagram.sharedSticker.backgroundImage": imgShare
            ]
        ]

        let pasteboardOptions = [
            UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(1)
        ]


        tempA = linkToShare ?? ""
        UIPasteboard.general.setItems(pasteboardItems, options: pasteboardOptions)
        //UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
        UIApplication.shared.open(urlScheme) { success in
            if success {
                //UIPasteboard.general.string = linkToShare
                print("success share to Instagram!")
                //print("Copy new string" + linkToShare!)
            }
        }
        
        // write to clipboard
//        let pasteboard = UIPasteboard(name: "Board", create: true)
//        pasteboard?.persistent = true
//        pasteboard?.strings = linkToShare
        
       // UIPasteboard.general.setItems(pasteboardItems, options: pasteboardOptions)

        result("sharing")
    }

}
