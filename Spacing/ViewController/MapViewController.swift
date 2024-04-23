//
//  MapViewController.swift
//  Spacing
//
//  Created by 최진문 on 2024/04/22.
//

import UIKit
import NMapsMap
import CoreLocation

class MapViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    var naverMapView: NMFNaverMapView = {
        let naverMapView = NMFNaverMapView()
        return naverMapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLocationData()
    }
    
    func setUI() {
        self.view.addSubview(naverMapView)
        naverMapView.mapView.positionMode = .normal
        naverMapView.showLocationButton = true
        
        naverMapView.translatesAutoresizingMaskIntoConstraints = false
        
        naverMapView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        naverMapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        naverMapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        naverMapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setLocationData() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let latitude = locationManager.location?.coordinate.latitude ?? 0
        let longtitude = locationManager.location?.coordinate.longitude ?? 0
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longtitude), zoomTo: 7)
        cameraUpdate.animation = .easeIn
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         if let location = locations.last {
             let latitude = location.coordinate.latitude
             let longitude = location.coordinate.longitude
             
             let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude), zoomTo: 7)
             cameraUpdate.animation = .easeIn
             naverMapView.mapView.moveCamera(cameraUpdate)
         }
     }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            // 권한이 없는 경우, 사용자에게 안내
            showAlert(title: "권한 필요", message: "위치 정보 사용을 위한 권한이 필요합니다.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let clError = error as? CLError else {return}
        
        switch clError.code {
        case .locationUnknown:
            showAlert(title: "위치오류", message: "현재 위치를 확인할 수 없습니다.")
        case .denied:
            // 위치 서비스 거부
            showAlert(title: "위치 서비스 거부됨", message: "위치 서비스를 활성화해주세요. 설정 > 개인 정보 보호 > 위치 서비스")
        case .network:
            // 네트워크 문제로 위치 정보를 받아올 수 없는 경우
            showAlert(title: "네트워크 오류", message: "네트워크 연결 상태를 확인해주세요.")
        default:
            // 기타 오류
            showAlert(title: "오류", message: "알 수 없는 오류가 발생했습니다.")
        }
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
