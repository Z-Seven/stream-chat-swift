//
// Copyright © 2020 Stream.io Inc. All rights reserved.
//

@testable import StreamChat
import StreamChatUI
import UIKit

import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        LogConfig.formatters = [
            PrefixLogFormatter(prefixes: [.info: "ℹ️", .debug: "🛠", .warning: "⚠️", .error: "🚨"]),
            PingPongEmojiFormatter()
        ]
        
        LogConfig.showThreadName = false
        LogConfig.showDate = false
        LogConfig.showFunctionName = false
        
        LogConfig.level = .warning
        
        LogStore.registerShared()
        
        setUpAppearance()

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { (isGranted, error) in
            print("Granted? \(isGranted), \(String(describing: error))")

            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly
        // after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    private func setUpAppearance() {
        UIConfig<DefaultExtraData>.default.navigation.channelListRouter = MyChatChannelListRouter.self
        ChatChannelListCollectionView.appearance().backgroundColor = .white
    }
    
    var deviceToken: Data?
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.deviceToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        print("Notification:", userInfo)
        print()
    }
}
