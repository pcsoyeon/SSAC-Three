//
//  MapViewController.swift
//  TMDBProject
//
//  Created by 소연 on 2022/08/11.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    // MARK: - UI Property
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Property
    
    private let locationManager = CLLocationManager()
    private var annotation = MKPointAnnotation()
    
    private var theaterList = TheaterList().mapAnnotations
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        setRegionAndAnnotation(title: "청년취업사관학교 영등포 캠퍼스")
    }
    
    // MARK: - Custom Method
    
    private func setRegionAndAnnotation(center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270),
                                        title: String) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1200, longitudinalMeters: 1200)
        
        mapView.setRegion(region, animated: true)
        setAnnotation(center: center, title: title)
        
        for theater in theaterList {
            let center = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
            self.setAnnotation(center: center, title: theater.location)
        }
    }
    
    func setAnnotation(center: CLLocationCoordinate2D, title: String) {
        let annotation =  MKPointAnnotation()
        
        annotation.coordinate = center
        annotation.title = title
        
        mapView.addAnnotation(annotation)
    }
    
    // MARK: - IBAction
    
    @IBAction func touchUpFilterButton(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "메가박스", style: .default, handler: { _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            for theater in self.theaterList.filter( { $0.type == "메가박스" } ) {
                let center = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
                self.setAnnotation(center: center, title: theater.location)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "롯데시네마", style: .default, handler: { _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            for theater in self.theaterList.filter({ $0.type == "롯데시네마" } ) {
                let center = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
                self.setAnnotation(center: center, title: theater.location)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "CGV", style: .default, handler: { _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            for theater in self.theaterList.filter( { $0.type == "CGV" } ) {
                let center = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
                self.setAnnotation(center: center, title: theater.location)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "전체보기", style: .default, handler: { _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            for theater in self.theaterList {
                let center = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
                self.setAnnotation(center: center, title: theater.location)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true)
    }
}

// MARK: - MapView Protocol

extension MapViewController: MKMapViewDelegate {
    
}

// MARK: - Authorization Method

extension MapViewController {
    func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있어 위치 권한 요청을 하지 못합니다.")
        }
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOT DETERMINED")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도")
            showRequestLocationServiceAlert()
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            locationManager.startUpdatingLocation()
        default:
            print("DEFAULT")
        }
    }
    
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}

// MARK: - CLLocation Protocol

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
        
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate, title: "나의 현재 위치")
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserDeviceLocationServiceAuthorization()
    }
}


