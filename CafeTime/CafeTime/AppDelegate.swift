//
//  AppDelegate.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/24/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import Firebase
import SwiftCop

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        
        let authVC = AuthenticatedUserVC()
        let nav = UINavigationController(rootViewController: authVC)
        
        let vcs = [nav, UIViewController()]
        
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers(vcs, animated: true)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.rootViewController = tabBarVC
            window.backgroundColor = UIColor.white
            window.makeKeyAndVisible()
        }
        
        let realm = RealmManager()
        
        guard let localCredentials = realm.localUserCredentials else {
            perform(#selector(presentLoginVC), with: nil, afterDelay: 0.01)
            return true
        }
        
        AuthManager.shared.authenticateUser(email: localCredentials.email, password: localCredentials.password, rememberUser: true, completion: { (error, success) in
            if success {
                return
            }
        })
        
        return true
    }
    
    @objc private func presentLoginVC() {
        let nav = UINavigationController(rootViewController: LoginVC())
        window?.rootViewController?.present(nav, animated: true, completion: nil)
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


private var firstLaunch : Bool = false

extension UIApplication {
    
    static func isFirstLaunch() -> Bool {
        let firstLaunchFlag = "LotFirstLaunchFlag"
        let isFirstLaunch = UserDefaults.standard.string(forKey: firstLaunchFlag) == nil
        if (isFirstLaunch) {
            firstLaunch = isFirstLaunch
            UserDefaults.standard.set("false", forKey: firstLaunchFlag)
            UserDefaults.standard.synchronize()
        }
        return firstLaunch || isFirstLaunch
    }
}
