//
//  SceneDelegate.swift
//  Uikit_UrlSession
//
//  Created by 유하은 on 5/22/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 새로운 씬이 생성될 때 호출됩니다. 여기서 UIWindow를 생성하고 연결합니다..
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // 씬이 해제될 때 호출됩니다. 리소스를 해제할 수 있습니다.

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // 씬이 활성화될 때 호출됩니다. 일시 중지된 작업을 다시 시작할 수 있습니다.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // 씬이 비활성화되기 직전에 호출됩니다. 작업을 일시 중지할 수 있습니다.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // 씬이 백그라운드에서 포그라운드로 전환될 때 호출됩니다. 백그라운드 상태 변경을 취소할 수 있습니다.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        //  씬이 포그라운드에서 백그라운드로 전환될 때 호출됩니다. 데이터를 저장하고 리소스를 해제할 수 있습니다.
    }


}

