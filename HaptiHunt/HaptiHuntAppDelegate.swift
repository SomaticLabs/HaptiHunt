//
//  HaptiHuntAppDelegate.swift
//  HaptiHunt
//
//  Created by Jacob Rockland on 4/11/18.
//  Copyright © 2018 Somatic Labs. All rights reserved.
//

import UIKit

/**
 Add delegate for adding haptic effects to Google Cardboard demo
 */
@UIApplicationMain
class HaptiHuntAppDelegate: UIResponder, UIApplicationDelegate {

    // Main UI window
    var window: UIWindow?

    /**
    Tells the delegate that the launch process is almost done and the app is almost ready to run.
    */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Hide navigation bar
        let navigationController = UINavigationController.init(rootViewController: HaptiHuntViewController())
        navigationController.isNavigationBarHidden = true
        
        // Set window bounds based on screen size
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        // Launch application
        return true
    }
}
