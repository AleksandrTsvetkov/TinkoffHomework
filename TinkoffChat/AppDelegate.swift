//
//  AppDelegate.swift
//  TinkoffChat
//
//  Created by Александр Цветков on 11.09.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if DEBUG
            print("Application is about to be moved from state 'not running' to state 'inactive': \(#function)")
        #endif
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
            print("Application moved from state 'not running' to state 'inactive': \(#function)")
        #endif
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        #if DEBUG
            print("Application moved from state 'inactive' to state 'active': \(#function)")
        #endif
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        #if DEBUG
            print("Application moved from state 'active' to state 'inactive': \(#function)")
        #endif
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        #if DEBUG
            print("Application moved from state 'inactive' to state 'background': \(#function)")
        #endif
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        #if DEBUG
        print("Application moved from state 'background' to state 'inactive': \(#function)")
        #endif
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        #if DEBUG
            print("Application moved from state 'background' to state 'not running': \(#function)")
        #endif
    }
}

