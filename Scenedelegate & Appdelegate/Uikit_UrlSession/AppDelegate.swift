//
//  AppDelegate.swift
//  Uikit_UrlSession
//
//  Created by 유하은 on 5/22/24.
//

import UIKit

// AppDelegate는 앱의 생명 주기를 관리하는 객체입니다. 
// 앱이 시작될 때, 백그라운드로 전환될 때, 다시 활성화될 때 등 주요 상태 변화에 대한 처리를 합니다.

@main
// @main 어노테이션은 이 클래스가 애플리케이션의 진입점(entry point)임을 나타냄

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // 앱이 런치되고 초기 설정을 할 때 호출됩니다.
        //이 메서드가 true를 반환하면 앱이 정상적으로 시작되었음을 의미합니다
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        /* 이 메서드는 새로운 씬 세션이 생성될 때 호출됩니다. 여기서는 새로운 씬을 구성하기 위해 UISceneConfiguration 객체를 반환합니다.
         name 파라미터는 씬의 설정을 정의하는 구성의 이름을 지정하고, 
         sessionRole 파라미터는 씬 세션의 역할을 지정합니다. */
        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
        /*
         이 메서드는 사용자가 씬 세션을 삭제할 때 호출됩니다. 
         이 메서드를 사용하여 삭제된 씬과 관련된 리소스를 해제할 수 있습니다.
         만약 앱이 실행되지 않는 동안 씬 세션이 삭제되었다면,
         application(_:didFinishLaunchingWithOptions:)
         메서드가 호출된 직후에 이 메서드가 호출됩니다.
         */
    }


}

