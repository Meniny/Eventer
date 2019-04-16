//
//  AppDelegate.swift
//  Sample
//
//  Created by 李二狗 on 2018/2/28.
//  Copyright © 2018年 Meniny Lab. All rights reserved.
//

import UIKit
import Eventer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    deinit {
        Eventer.unregister(self)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Eventer.onMainThread(self, name: EventName.didLoad.rawValue) { (_) in
            print(EventName.didLoad.rawValue)
        }
        
        Eventer.onMainThread(self, name: EventName.didAppear.rawValue) { (_) in
            print(EventName.didAppear.rawValue)
        }
        
        Eventer.onMainThread(self, name: EventName.didDisAppear.rawValue) { (_) in
            print(EventName.didDisAppear.rawValue)
        }
        
        Eventer.onMainThread(self, name: EventName.didBecomeActive.rawValue) { (_) in
            print(EventName.didBecomeActive.rawValue)
        }
        
        Eventer.onMainThread(self, name: EventName.didEnterBackground.rawValue) { (_) in
            print(EventName.didEnterBackground.rawValue)
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        Eventer.post(EventName.didEnterBackground.rawValue, on: .main)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        Eventer.post(EventName.didBecomeActive.rawValue, on: .main)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

