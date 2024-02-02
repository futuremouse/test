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
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Guard 문을 사용하여 UIWindowScene 객체를 안전하게 언래핑합니다.
        guard let _ = (scene as? UIWindowScene) else { return }
//
//        // 메인 뷰 컨트롤러 인스턴스를 생성합니다.
//        let mainViewController = MainViewController()
//
//        // 메인 뷰 컨트롤러를 UINavigationController에 내장시킵니다.
//        let navigationController = UINavigationController(rootViewController: mainViewController)
//
//        // UIWindow 객체를 생성하고, rootViewController로 navigationController를 설정합니다.
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = navigationController  // rootViewController 설정
//        self.window = window
//        window.makeKeyAndVisible()  // 윈도우를 키 윈도우로 설정하고 화면에 표시합니다.
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

