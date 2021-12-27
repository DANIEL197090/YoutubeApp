//
//  SceneDelegate.swift
//  SideMenu
//
//  Created by Decagon on 07/11/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 
    guard let scene  = (scene as? UIWindowScene) else { return }
    let windows = UIWindow(windowScene: scene)
    windows.rootViewController = UINavigationController(rootViewController: HomeController(
    collectionViewLayout: UICollectionViewFlowLayout()))
    UINavigationBar.appearance().barTintColor = .red
    windows.makeKeyAndVisible()
    self.window = windows
  }

  func sceneDidDisconnect(_ scene: UIScene) {
   
  }

  func sceneDidBecomeActive(_ scene: UIScene) {

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
    
  }


}


