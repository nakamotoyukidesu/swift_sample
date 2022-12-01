//
//  AppDelegate.swift
//  RamenInfo
//
//  Created by 藤田優作 on 2021/01/11.
//

import UIKit
import Firebase
import GoogleMobileAds
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
    
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if FirebaseApp.app() == nil {
                    FirebaseApp.configure()
                }
               // 通知に必要なのはここからしたの処理
               if #available (iOS 10.0, *) {
                   // For iOS 10 display notification (sent via APNS)
                   UNUserNotificationCenter.current().delegate = self

                   let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                   UNUserNotificationCenter.current().requestAuthorization(
                       options: authOptions,
                       completionHandler: {_, _ in })
               } else {
                   let settings: UIUserNotificationSettings =
                       UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                   application.registerUserNotificationSettings(settings)
               }

               application.registerForRemoteNotifications()
        // Override point for customization after application launch.
        if FirebaseApp.app() == nil {
                    FirebaseApp.configure()
                }
        GADMobileAds.configure(withApplicationID: "ca-app-pub-1176501795873489~8789480659")
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        Auth.auth().signInAnonymously() { (authResult, error) in
                    if error != nil{
                        print("Auth Error :\(error!.localizedDescription)")
                    }

                     // 認証情報の取得
                     guard let user = authResult?.user else { return }
                     let isAnonymous = user.isAnonymous  // true
                     let uid = user.uid
                    return
                }
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
           // Print message ID.
           if let messageID = userInfo["gcm.message_id"] {
               print("Message ID: \(messageID)")
           }

           // Print full message.
           print(userInfo)
       }

       func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
           // Print message ID.
           if let messageID = userInfo["gcm.message_id"] {
               print("Message ID: \(messageID)")
           }

           // Print full message.
           print(userInfo)

           completionHandler(UIBackgroundFetchResult.newData)
       }


}
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
   func userNotificationCenter(_ center: UNUserNotificationCenter,
                               willPresent notification: UNNotification,
                               withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
       let userInfo = notification.request.content.userInfo

       if let messageID = userInfo["gcm.message_id"] {
           print("Message ID: \(messageID)")
       }

       print(userInfo)

       completionHandler([])
   }

   func userNotificationCenter(_ center: UNUserNotificationCenter,
                               didReceive response: UNNotificationResponse,
                               withCompletionHandler completionHandler: @escaping () -> Void) {
       let userInfo = response.notification.request.content.userInfo
       if let messageID = userInfo["gcm.message_id"] {
           print("Message ID: \(messageID)")
       }

       print(userInfo)

       completionHandler()
   }
}


