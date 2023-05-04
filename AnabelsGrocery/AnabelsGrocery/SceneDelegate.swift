//
//  SceneDelegate.swift
//  AnabelsGrocery
//
//  Created by Phyllis Ju on 4/28/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var tabBarController: UITabBarController?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Create the tab bar controller
        tabBarController = UITabBarController()

        // Create and add child view controllers
        let inventoryViewController = ViewController()
        inventoryViewController.title = "Products"
        inventoryViewController.tabBarItem = UITabBarItem(title: "Products", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let navigationControllerInventory = UINavigationController(rootViewController: inventoryViewController)

        let menuViewController = MenuViewController()
        menuViewController.title = "Recipes"
        menuViewController.tabBarItem = UITabBarItem(title: "Recipes", image: UIImage(systemName: "list.dash"), selectedImage: UIImage(systemName: "list.dash.circle.fill"))
        let navigationControllerMenu = UINavigationController(rootViewController: menuViewController)

        let cartViewController = ShoppingCartViewController()
        cartViewController.title = "Cart"
        cartViewController.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        let navigationControllerCart = UINavigationController(rootViewController: cartViewController)
        
        let reservationViewController = ReservationViewController()
        reservationViewController.title = "Reservation"
        reservationViewController.tabBarItem = UITabBarItem(title: "Reservation", image: UIImage(systemName: "checkmark.circle"), selectedImage: UIImage(systemName: "checkmark.circle.fill"))
        let navigationControllerReservation = UINavigationController(rootViewController: reservationViewController)

        tabBarController?.viewControllers = [navigationControllerInventory, navigationControllerMenu, navigationControllerCart, navigationControllerReservation]

        // Set the tab bar controller as the root view controller for this scene
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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

