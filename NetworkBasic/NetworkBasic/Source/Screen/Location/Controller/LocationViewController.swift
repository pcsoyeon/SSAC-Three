//
//  LocationViewController.swift
//  NetworkBasic
//
//  Created by 소연 on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController {

    // Notfication 1. 인스턴스 생성
    // UN - User Notification
    let notificationCenter = UNUserNotificationCenter.current()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        checkFontFile()
//        requestAuthorization()
    }

    @IBAction func touchUpNotificationButton(_ sender: UIButton) {
        sendNotification()
    }
    
    // MARK: - Custom Method
    
    private func checkFontFile() {
        // Custom Font
        for family in UIFont.familyNames {
            print("========\(family)========")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print(name)
            }
        }
    }
    
    private func requestAuthorization() {
        // Notification 2. 권한 요청
        // options: completionHanler: - 옵션 설정 가능 (뱃지, 사운드 ...)
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        notificationCenter.requestAuthorization(options: authorizationOptions) { success, error in
            // Bool: 사용자가 접근 권한을 허용 했는지, 안했는지
            // Error: 오류에 대한 대응
            
            // 사용자가 허용을 했을 때만 언제, 어떤 내용으로 구상할 지 알림을 보내라는 안내 메시지 구성
            self.sendNotification()
        }
    }
    
    // Notification 3. 권한 허용한 사용자에게 알림 요청 - 언제/어떤 내용을 보낼 것인가
    // iOS 시스템에서 알림을 담당 > 알림 등록
    
    /*
     
     - 권한 허용 해야만 알림이 옴
     - 권한 허용 문구 시스템적으로 최소 한번만 가능
     - 허용 안된 경우, 애플 설정으로 유도하는 코드 구성
     
     - 기본적으로 알림은 포그라운드에서 수신 불가
     - 로컬 알림에서 60초 이상 반복 가능 / 개수 제한 64개 / 커스텀 사운드 30초 제한
     
     + @
     - 노티는 앱 실행이 기본, 특정 노티에 따라서 원하는 (특정) 화면으로 가고 싶다면?
     - 포그라운드 수신, 특정 화면에서는 안받고 특정 조건에 대해서만 포그라운 수신을 하고 싶다면?
     - iOS 15 집중 모드 등 5~6 우선순위 존재 
     
     1. 뱃지 제거?
     2. 노티 제거?
     3. foreground 일 때?
     */
    
    private func sendNotification() {
        let notificationContent = UNMutableNotificationContent() // 클래스의 인스턴스이므로 let으로 선언해도 프로퍼티 수정 가능
        
        // 어떤 내용을 보낼지
        notificationContent.title = "다마고치를 키워보세요"
        notificationContent.subtitle = "오늘 행운의 숫자는 \(Int.random(in: 1...101))"
        notificationContent.body = "저는 따끔따끔 다마고치입니다. 배고파요. :("
        notificationContent.badge = 25
        
        // 언제 보낼지
        // 1. 시간 간격
        // 2. 캘린더
        // 3. 위치에 따라 설정 가능
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // 5초 뒤, 반복 X
        
//        var dateComponent = DateComponents()
//        dateComponent.minute = 15
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        // content, trigger를 담기 위한 객체 생성
        // 알림 요청
        // identifier:
        // 만약 알림 관리할 필요 X -> 알림 클릭하면 앱을 켜주는 정도
        // 만약 알리 관리할 필요 O -> 고유 이름, 규칙 등
        // 같은 내용이어도 identifier가 다르기 때문에 알림이 쌓일 수 있음 "\(Date())"
        // 만약, 고정되어 있는 이름이라면? (항상 똑같다면?)
        let request = UNNotificationRequest(identifier: "SOKYTE", content: notificationContent, trigger: trigger)
        notificationCenter.add(request) { error in
            // 만약 실패/오류 했을 때,
            print(error)
        }
    }
}
