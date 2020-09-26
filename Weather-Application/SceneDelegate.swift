//
//  SceneDelegate.swift
//  Weather-Application
//
//  Created by sdf on 9/18/20.
//  Copyright © 2020 vmodzolevskii. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
      
        // MARK: Init
        let presenter = WeatherPresenter()
        let weatherVC = WeatherViewController(presenter: presenter)
        let forecastVC = ForecastViewController(presenter: presenter)
        let controllers = [weatherVC, forecastVC]
        
        setBarImages(weatherVC: weatherVC, forecastVC: forecastVC)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
        tabBarController.selectedViewController = weatherVC
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func setBarImages(weatherVC: UIViewController, forecastVC: UIViewController) {
        let weatherItem = UITabBarItem()
        weatherItem.title = "Today"
        
        let weatherImage = UIImage(named: "Sun")
        let targetSize = CGSize(width: 30, height: 30)
        let scaledImage = weatherImage!.scalePreservingAspectRatio(targetSize: targetSize)
        weatherItem.image = scaledImage
        weatherVC.tabBarItem = weatherItem
        
        let forecastItem = UITabBarItem()
        forecastItem.title = "Forecast"
        let forecastImage = UIImage(named: "Forecast")
        let forecastScaledImage = forecastImage!.scalePreservingAspectRatio(targetSize: targetSize)
        forecastItem.image = forecastScaledImage
        forecastVC.tabBarItem = forecastItem
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

