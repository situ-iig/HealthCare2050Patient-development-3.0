import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain

@objc class AppDelegate: FlutterAppDelegate {
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
            //GeneratedPluginRegistrant.register(with: self)
            // set the delegate in didFinishLaunchingWithOptions
            UNUserNotificationCenter.current().delegate = self
            GMSServices.provideAPIKey("AIzaSyDAmUHmAnmkjKmXLDg5lYGm6dfkVaHsbUM")
            GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
        
           // This method will be called when app received push notifications in foreground
            func UserNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
            {
                completionHandler([.alert, .badge, .sound])
            }
   }
                                                                                                                                                                                           
