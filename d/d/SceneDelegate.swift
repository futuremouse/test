//
//  SceneDelegate.swift
//  d
//
//  Created by t2023-m0024 on 1/30/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    

//        let view01 = UIViewController()
//        view01.view.backgroundColor = .white
//        let view02 = UIViewController()
//        view01.view.backgroundColor = .black
//        let view03 = UIViewController()
//        view01.view.backgroundColor = .blue
//        
//        // 현재 윈도우의 루트 뷰를 tab bar controller로 지정
//        self.window?.rootViewController = tbc
    

//        // 탭바컨트롤러에 컨텐츠 컨트롤러 뷰 추가
//        tbc.setViewControllers([view01, view02, view03], animated: false)
//        
//        view01.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "img.png"), tag: 0)
//        view02.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profile"), tag: 1)
//        view03.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "img.png"), tag: 2)
//                        
//        tbc.tabBar.backgroundColor = .yellow
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

