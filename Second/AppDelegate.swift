//
//  AppDelegate.swift
//  Second
//
//  Created by Собко Евгений on 31.03.2018.
//  Copyright © 2018 Sobko Evgeniy. All rights reserved.
//

import Foundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        func setupTabBarProperties(forTabBarController tabBarController: UITabBarController) {
            tabBarController.tabBar.tintColor = Constants.tabBarSelectedImageColor
            UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor : Constants.tabBarSelectedTextColor], for: .selected)
            tabBarController.tabBar.backgroundColor = Constants.tabBarBackgroundColor.withAlphaComponent(Constants.tabBarBackgroundAlpha)
            tabBarController.tabBar.backgroundImage = UIImage()
            tabBarController.tabBar.shadowImage = UIImage()
        }
        
        func viewControllersForMainTabBar() -> [UIViewController] {
            var viewControllers = [UIViewController]()
            var viewController: UIViewController = HomeCollectionViewController(collectionViewLayout: PictureCollectionViewLayout())
            viewControllers.append(viewController)
            for controllerTitle in Constants.controllersTitles {
                viewController = UIViewController()
                viewController.view.backgroundColor = Constants.backgroundColorOfViews
                viewController.tabBarItem = UITabBarItem(title: controllerTitle, image: UIImage(imageLiteralResourceName: controllerTitle), selectedImage: nil)
                viewControllers.append(viewController)
            }
            return viewControllers
        }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let mainMenuViewController = UITabBarController()
        setupTabBarProperties(forTabBarController: mainMenuViewController)
        mainMenuViewController.viewControllers = viewControllersForMainTabBar()
        window.rootViewController = mainMenuViewController
        window.makeKeyAndVisible()
        
        self.window = window
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this m/Users/Zombie/Swift/Ya/Second/Second.xcodeprojethod to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
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

    enum Constants {
        static let tabBarSelectedImageColor = #colorLiteral(red: 0.7497641444, green: 0.02775303088, blue: 0.1031884477, alpha: 1)
        static let tabBarSelectedTextColor = #colorLiteral(red: 0.3136630654, green: 0.3135992587, blue: 0.3218442202, alpha: 1)
        static let tabBarBackgroundColor = UIColor.white
        static let tabBarBackgroundAlpha: CGFloat = 0.95
        static let controllersTitles = ["Explore", "Notifications", "Saved"]
        static let backgroundColorOfViews = UIColor.white
    }
    
}

