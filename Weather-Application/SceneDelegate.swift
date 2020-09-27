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
    
    private func setBarImages(weatherVC: UIViewController, forecastVC: UIViewController) {
        let weatherItem = UITabBarItem()
        weatherItem.title = "Today"
        
        guard let weatherImage = UIImage(named: "Sun") else { return }
        weatherItem.image = weatherImage.scalePreservingAspectRatio(
                                                        targetSize: CGSize(width: 30, height: 30))
        weatherVC.tabBarItem = weatherItem
        
        
        let forecastItem = UITabBarItem()
        forecastItem.title = "Forecast"
        guard let forecastImage = UIImage(named: "Forecast") else { return }
        let forecastScaledImage = forecastImage.scalePreservingAspectRatio(
                                                        targetSize: CGSize(width: 30, height: 30))
        forecastItem.image = forecastScaledImage
        forecastVC.tabBarItem = forecastItem
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

