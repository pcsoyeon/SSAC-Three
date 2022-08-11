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
    
    private var locationManager = CLLocationManager()
    private let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRegionAndAnnotation(center: center)
    }
    
    // MARK: - Custom Method
    
    private func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "SeSAC 영등포 캠퍼스"
        mapView.addAnnotation(annotation)
    }
    
    @IBAction func touchUpFilterButton(_ sender: UIBarButtonItem) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let megaBoxAction = UIAlertAction(title: "메가박스", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        let lotteAction = UIAlertAction(title: "롯데시네마", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        let cgvAction = UIAlertAction(title: "CGV", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        let totalAction = UIAlertAction(title: "전체보기", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        optionMenu.addAction(megaBoxAction)
        optionMenu.addAction(lotteAction)
        optionMenu.addAction(cgvAction)
        optionMenu.addAction(totalAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
}

// MARK: - MapView Protocol

extension MapViewController: MKMapViewDelegate {
    
}
