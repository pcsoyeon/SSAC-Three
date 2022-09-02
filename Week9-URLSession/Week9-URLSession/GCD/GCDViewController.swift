//
//  GCDViewController.swift
//  Week9-URLSession
//
//  Created by 소연 on 2022/09/02.
//

import UIKit

final class GCDViewController: UIViewController {
    
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
    let url2 = URL(string: "https://apod.nasa.gov/apod/image/2112/M3Leonard_Bartlett_3843.jpg")!
    let url3 = URL(string: "https://apod.nasa.gov/apod/image/2112/LeonardMeteor_Poole_2250.jpg")!
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func serialSync(_ sender: UIButton) {
        print("START")
        
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
        // 교착상태 (데드락) : 쓸 일 없음
        DispatchQueue.main.sync {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        print("END")
    }
    
    @IBAction func serialAsync(_ sender: UIButton) {
        print("START")
        
//        DispatchQueue.main.async {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
        
        for i in 1...100 {
            DispatchQueue.main.async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
    }
    
    @IBAction func globalSync(_ sender: UIButton) {
        print("START")
        
        // -> 결국 메인쓰레드가 작업하는 것과 유사하게 동작하므로 메인 쓰레드로 일을 보냄 : 쓸 일 없음
        DispatchQueue.global().sync {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
    }
    
    @IBAction func globalAsync(_ sender: UIButton) {
        print("START \(Thread.isMainThread)")
        
        
        for i in 1...100 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
        
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END \(Thread.isMainThread)")
    }
    
    @IBAction func qos(_ sender: UIButton) {
//        DispatchQueue.global(qos: .background).async {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
//
//        DispatchQueue.global(qos: .userInteractive).async {
//            for i in 101...200 {
//                print(i, terminator: " ")
//            }
//        }
//
//        DispatchQueue.global(qos: .utility).async {
//            for i in 201...300 {
//                print(i, terminator: " ")
//            }
//        }
        
        let customQueue = DispatchQueue(label: "concurrentSeSAC", qos: .userInteractive, attributes: .concurrent)
        
        customQueue.async {
            print("START")
        }
        
        for i in 1...100 {
            DispatchQueue.global(qos: .background).async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            DispatchQueue.global(qos: .userInteractive).async {
                print(i, terminator: " ")
            }
        }
        
        for i in 201...300 {
            DispatchQueue.global(qos: .utility).async {
                print(i, terminator: " ")
            }
        }
    }
    
    @IBAction func dispatchGroup(_ sender: UIButton) {
        
        // 세가지 비동기 처리에 대한 신호를 받을 그룹 생성
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        group.notify(queue: .main) { // global, main 모두 가능하지만 >> 일반적으로 UI 업데이트가 많기 때문에 main을 좀 더 많이 사용
            print("끝났당") // tableView.reload
        }
    }
    
    @IBAction func dispatchGroupNASA(_ sender: UIButton) {
        
//        NASAAPIManager.request(url: url1) { image in
//            print("1")
//        }
//
//        NASAAPIManager.request(url: url2) { image in
//            print("2")
//        }
//
//        NASAAPIManager.request(url: url3) { image in
//            print("3")
//        }
        
//        NASAAPIManager.request(url: url1) { image in
//            print("1")
//
//            NASAAPIManager.request(url: url2) { image in
//                print("2")
//
//                NASAAPIManager.request(url: url3) { image in
//                    print("3")
//                    print("끝 >> 갱신")
//                }
//            }
//        }
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            NASAAPIManager.request(url: self.url1) { image in
                print("1 받음요")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            NASAAPIManager.request(url: self.url2) { image in
                print("2 받음요")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            NASAAPIManager.request(url: self.url3) { image in
                print("3 받음요")
            }
        }
        
        group.notify(queue: .main) {
            print("끝. 갱신하셈.")
        }
        // -> noti를 먼저 받음
        // 왜? 네트워크 함수는 비동기 함수 >> request로 들어가면 >> dataTask가 동작 >> 디스패치 그룹에 등록이 된 코드가 있는데 그 아래는 다른 쓰레드(비동기코드이므로)
        // >> 그래서 디스패치 그룹의 경우 내부적인 코드가 동기적으로 동작하면 문제가 없는데,
        // >> 네트워크 코드와 같이 비동기적으로 동작하는 코드라면 원하는 방식으로 동작하지 않음
        // 다른 쓰레드의 작업은 끝날때까지 기다리지 않음
    }
    
    func a() {
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            NASAAPIManager.request(url: self.url1) { image in
                print(1)
            }
            NASAAPIManager.request(url: self.url3) { image in
                print(2)
            }
            NASAAPIManager.request(url: self.url3) { image in
                print(3)
            }
        }
    }
    
    func b() {
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            NASAAPIManager.request(url: self.url1) { image in
                print(1)
            }
            
        }
        DispatchQueue.global().async(group: group) {
            NASAAPIManager.request(url: self.url2) { image in
                print(2)
            }
        }
        DispatchQueue.global().async(group: group) {
            NASAAPIManager.request(url: self.url3) { image in
                print(3)
            }
        }
    }
    
    @IBAction func enterLeave(_ sender: UIButton) {
        let group = DispatchGroup()
        var imageList: [UIImage] = []
        
        group.enter() // RC + 1 : 들어감
        NASAAPIManager.request(url: url1) { image in
            print("1")
            if let image = image {
                imageList.append(image)
            }
            group.leave() // RC - 1 : 끝났음
        }
        // enter - leave의 개수를 맞춰야 함 -> ARC 개념과 연관
        
        group.enter()
        NASAAPIManager.request(url: url2) { image in
            print("2")
            if let image = image {
                imageList.append(image)
            }
            group.leave()
        }
        
        group.enter()
        NASAAPIManager.request(url: url3) { image in
            print("3")
            if let image = image {
                imageList.append(image)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("THE END") // RC가 0이 되는 시점에서 실행 (Reference Count)
            
            self.firstImageView.image = imageList[0]
            self.secondImageView.image = imageList[1]
            self.thirdImageView.image = imageList[2]
        }
    }
    
    @IBAction func raceCondition(_ sender: UIButton) {
        let group = DispatchGroup()
        
        var nickname = "SeSAC"
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "고래밥"
            print("first: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "칙촉"
            print("second: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "올라프"
            print("thrid: \(nickname)")
        }
        
        group.notify(queue: .main) {
            print("result: \(nickname)")
        }
    }
}
