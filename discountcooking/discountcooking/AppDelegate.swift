//
//  AppDelegate.swift
//  discountcooking
//
//  Created by Kaahan Radia on 10/15/17.
//  Copyright © 2017 Kaahan Radia. All rights reserved.
//

import UIKit
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        UINavigationBar.appearance().barTintColor = colors["apricot"]
        UINavigationBar.appearance().tintColor = colors["light-grey"]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: colors["light-grey"], NSAttributedStringKey.font: UIFont(name: "Gravity", size: 17)!]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Gravity", size:17)!], for: .normal)
        UITabBar.appearance().barTintColor = colors["apricot"]
        UITabBar.appearance().tintColor = colors["light-grey"]
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: colors["light-grey"], NSAttributedStringKey.font: UIFont(name: "Gravity", size: 12)!], for: .normal)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

