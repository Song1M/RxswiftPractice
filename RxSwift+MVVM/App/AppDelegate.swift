//
//  AppDelegate.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import UIKit

import Firebase
import Then


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var coordinator: AppCoordinator?
    
    var deviceToken: String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        
        let navController = UINavigationController()
        
        // coordinator 인스턴스 생성
        coordinator = AppCoordinator(presenter: navController)
        // Coordinator로 첫 화면 열기
        coordinator?.start(animated: true)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        
        CookieManager.shared.restoreCookie()
        KeychainManager.shared.setUUID()
        
        FirebaseApp.configure()                 // 1
        Messaging.messaging().delegate = self   // 2

        
        return true
        
    }
    
    // deviceToken 등록 성공시 실행되는 메서드
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var token: String = ""
        for i in 0..<deviceToken.count {
            token += String(format: "%02.2hhx", deviceToken[i] as CVarArg)
        }
        
        log.verbose("deviceToken 등록 성공: \(token)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // deviceToken 등록 실패시 실행되는 메서드
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        log.error("deviceToken 등록 실패: \(error.localizedDescription)")
    }

}

// MARK:- MessagingDelegate

extension AppDelegate: MessagingDelegate {
    // 토큰이 업데이트 될 때마다 호출.
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        deviceToken = fcmToken
        log.verbose("Firebase registration token: \(String(describing: fcmToken))")
        // deviceToken을 업데이트하는 api를 호출해야 함.
    }
    
}
