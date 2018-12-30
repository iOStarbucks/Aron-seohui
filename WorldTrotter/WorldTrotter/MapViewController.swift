//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by seohui on 30/09/2018.
//  Copyright © 2018 seohui. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    // 뷰 컨트롤러는 view를 요청해서 그 값이 nil 이면 loadView() 메서드를 호출한다.
    override func loadView() {
        // 지도 뷰 생성
        mapView = MKMapView()
        
        // 지도 뷰를 이 뷰 컨트롤러의 view로 설정
        view = mapView
        
        let segmentControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentControl.selectedSegmentIndex = 0
        
        segmentControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
        
        // autoresizing mask property false로 설정. 기본 변환 사용하지 않도록 한다.
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentControl)
        
        // anchor를 사용해 제약조건 만들기. ahchor : view의 property.
        let topConstraint = segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        //let leadingConstraint = segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        //let trailingConstraint = segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        // NSLayoutConstraint의 active property를 true로 설정.
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    @objc
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        // super의 viewDidLoad 구현을 항상 호출한다
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
        
        let button = UIButton()
        button.frame = CGRect(x: 285, y: 550, width: 100, height: 100)
        button.setTitle("Current", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 50
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderWidth = 3.0
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)

        self.view.addSubview(button)
    }
    
    // current location
    @objc func buttonClicked(sender : UIButton){
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() //권한 요청
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        let coor = locationManager.location?.coordinate
        
        print("latitude : " + String(describing: coor!.latitude) + "/ longitude : " + String(describing: coor!.longitude))
        
        self.mapView.showsUserLocation = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //위치가 업데이트될때마다
        if let coor = manager.location?.coordinate{
            print("latitude" + String(coor.latitude) + "/ longitude" + String(coor.longitude))
        }
        
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapView.setRegion(region, animated: false)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: " + error.localizedDescription, terminator: "")
    }
}
