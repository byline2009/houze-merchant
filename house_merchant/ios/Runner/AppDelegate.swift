import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var APP_RECEIVE_NOTIFICATION = "com.house.merchant/receive_notification"

    var receiveNotificationStreamHandler: StreamHandle?
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        Thread.sleep(forTimeInterval: 1.0)
        
        self.initAllChannel()
        
        // [START register_for_notifications]
        
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        
        application.registerForRemoteNotifications()
        
        // [END register_for_notifications]
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        UserDefaults.standard.set(token, forKey: "device_token")
        UserDefaults.standard.synchronize()
    }
    
    override func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func initAllChannel() {
        let controller: FlutterViewController = self.window?.rootViewController as! FlutterViewController
        let sizeChannel = FlutterMethodChannel.init(name: "com.house.merchant", binaryMessenger: controller.binaryMessenger)
        sizeChannel.setMethodCallHandler { (call, result) in
            if "size".compare(call.method) == .orderedSame {
                let a = [
                    [UIScreen.main.bounds.size.width],
                    [UIScreen.main.bounds.size.height]
                ]
                result(a)
            } else if "device_token".compare(call.method) == .orderedSame {
                let token = UserDefaults.standard.string(forKey: "device_token") ?? ""
                result(token)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        self.receiveNotificationStreamHandler = StreamHandle()
        FlutterEventChannel.init(name: self.APP_RECEIVE_NOTIFICATION, binaryMessenger: controller.binaryMessenger).setStreamHandler((self.receiveNotificationStreamHandler as! FlutterStreamHandler & NSObjectProtocol))
    }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        print(userInfo)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewsfeedReload"), object: nil)
        // Change this to your preferred presentation option
        completionHandler([.alert, .sound, .badge])
    }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        // Print full message.
        print(userInfo)
        
        let jsonData = DictionaryToJSONString(dict: userInfo)
        if let jsonData = DictionaryToJSONString(dict: userInfo) {
            self.receiveNotificationStreamHandler?.excuteEventSink(data: jsonData)
        }
        completionHandler()
    }
    
    func DictionaryToJSONString(dict: [AnyHashable :Any]) -> String?{
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString
    }
}
