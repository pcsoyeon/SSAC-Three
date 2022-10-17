//
//  AppDelegate.swift
//  FirebaseExample
//
//  Created by 소연 on 2022/10/05.
//

import UIKit

import FirebaseCore
import FirebaseMessaging

import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        aboutRealmMigration()
        
        UIViewController.swizzleMethod() // 괄호(인스턴스가 아니라 타입으로)로 호출할 수 없음
        
        FirebaseApp.configure()
        
        // 원격 알림 시스템에 앱을 등록
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        // 메시지 대리자 설정
        Messaging.messaging().delegate = self
        
        // 현재 등록된 토큰 가져오기
//        Messaging.messaging().token { token, error in
//            if let error = error {
//                print("Error fetching FCM registration token: \(error)")
//            } else if let token = token {
//                print("FCM registration token: \(token)")
//            }
//        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // 재구성 사용 중지됨: APNs 토큰과 등록 토큰 매핑
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // foreground 알림 수신: 로컬 푸시와 동일
    // 카카오톡: 후리방구와의 채팅방, 푸시마다 설정, 화면마다 설정 ..
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        guard let viewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        
        // setting 뷰에 있을 대는 포그라운드 푸시 띄우지 않도록
        if viewController is SettingViewController {
            // 배지만
            completionHandler([.badge])
            
            // 아무것도 X
            completionHandler([])
        } else {
            // .banner, .list, iOS 14+
            completionHandler([.badge, .sound, .banner, .list])
        }
        
        
    }
    
    // push click: 특정 화면으로 이동
    
    // 유저가 푸시를 클릭했을 때만 수신확인 가능
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("🍋 사용자가 푸시를 클릭했습니다. 🍋")
        
        print(response.notification.request.content.body) // 알림 메시지의 내용
        print(response.notification.request.content.userInfo) // 딕셔너리 타입 (키:값)
        
        let userInfo = response.notification.request.content.userInfo
        
        if userInfo[AnyHashable("sesac")] as? String == "project" {
            print("🍋 project 알림이 왔음요 🍋")
        } else {
            print("🍊 다른 알림이 왔음요 🍊")
        }
        
        guard let viewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        print(viewController)
        
        // 클래스의 인스턴스 비교
        // 만약 최상단의 뷰가 ViewController라면 설정 뷰로 이동
        if viewController is ViewController {
            viewController.navigationController?.pushViewController(SettingViewController(), animated: true)
        }
        // 프로필 뷰라면 dismiss
        else if viewController is ProfileViewController {
            viewController.dismiss(animated: true)
        }
    }
    
    // UNNotificationInterruptionLevel (iOS 15이후부터)
    
}

extension AppDelegate: MessagingDelegate {
    // 토큰 갱신 모니터링: 토큰 정보가 바뀔 때 (언제? 왜?)
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}

extension AppDelegate {
    func aboutRealmMigration() {
        // deleteRealmIfMigrationNeeded: 마이그레이션이 필요한 경우 기존 렘 삭제 (스키마 0부터 모두 초기화, 기존의 정보 고려X)
        // ✅ -> Realm Browser 닫고 다시 열기 !!!!!!
//        let config = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true)

        let config = Realm.Configuration(schemaVersion: 6) { migration, oldSchemaVersion in
            // 여기서 버전 대응
            if oldSchemaVersion < 1 {
                
            }
            
            // else if로 대응하지 않는 이유?
            // 버전마다 대응을 해야 하므로 
            if oldSchemaVersion < 2 {
                
            }
            
            if oldSchemaVersion < 3 {
                migration.renameProperty(onType: Todo.className(), from: "importance", to: "favorite")
            }
            
            if oldSchemaVersion < 4 {
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
                    new["userDescription"] = "안녕하세요? \(old["title"]!)의 중요도는 \(old["favorite"]!)입니다"
                }
            }
            
            if oldSchemaVersion < 5 {
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    new["count"] = 100
                }
            }
            
            if oldSchemaVersion < 6 {
                migration.enumerateObjects(ofType: Todo.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
                    new["favorite"] = old["favorite"]
                }
            }
        }
        
        Realm.Configuration.defaultConfiguration = config
    }
}
