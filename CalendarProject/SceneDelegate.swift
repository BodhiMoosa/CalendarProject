//
//  SceneDelegate.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 5/27/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?



        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene                                   = (scene as? UIWindowScene) else { return }
            window                                                  = UIWindow(frame: UIScreen.main.bounds)
            window?.windowScene                                     = windowScene
            window?.rootViewController                              = createInitialViewController()
            window?.makeKeyAndVisible()
    }

        func createInitialViewController() -> UITabBarController {
            let vc = UITabBarController()
            vc.viewControllers = [createDropDownVC(), createSlidingVC()]
            return vc
        }
    
    func createSlidingVC() -> UINavigationController {
        let vc = SlidingCalendarVC()
        vc.tabBarItem = UITabBarItem(title: "Sliding Option", image: Images.calendarOne, tag: 1)
        vc.title = "Sliding Option"
        return UINavigationController(rootViewController: vc)
    }
    
    func createDropDownVC() -> UINavigationController {
        let vc = SecondVC()
        vc.tabBarItem = UITabBarItem(title: "DropDown Option", image: Images.calendarOne, tag: 2)
        vc.title = "DropDown Option"
        return UINavigationController(rootViewController: vc)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

