//
//  AppDelegate.swift
//  CharlesGuide
//
//  Created by Tam Nguyen M. on 3/11/19.
//  Copyright © 2019 Tam Nguyen M. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Config not cache data
        URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)

        // Config network indicator
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        // Config window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        window?.rootViewController = ChecklistVC()
        return true
    }
}

