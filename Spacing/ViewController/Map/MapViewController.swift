//
//  MapViewController.swift
//  Spacing
//
//  Created by 최진문 on 2024/04/22.
//

import UIKit
import NMapsMap
import CoreLocation
import SnapKit

class MapViewController: UIViewController, NMFMapViewTouchDelegate {
    
    var locationManager = CLLocationManager()
    var naverMapView = NMFNaverMapView()
    let infoWindow = NMFInfoWindow()
    let dataSource = NMFInfoWindowDefaultTextSource.data()
    
    var isInitalLocationUpdate = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        alertLocationAuth()
        for place in Place.data {
            setMarker(lat: place.lat, lng: place.lng, title: place.title)
        }
        naverMapView.mapView.touchDelegate = self
    }
    
    func setUI() {
        navigationItem.setHidesBackButton(true, animated: false)
        naverMapView.mapView.positionMode = .normal
        naverMapView.showLocationButton = true
        
        naverMapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(naverMapView)
        naverMapView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func alertLocationAuth() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func setMarker(lat : Double, lng: Double, title : String) {
        let testMarker = NMFMarker()
        testMarker.position = NMGLatLng(lat: lat, lng: lng)
        testMarker.captionText = title
        testMarker.userInfo = ["title" : title]
        testMarker.mapView = naverMapView.mapView // 지도상에 마커를 나타냄

        infoWindow.dataSource = dataSource
    
        
        let handler = { [weak self] (overlay: NMFOverlay) -> Bool in
            if let marker = overlay as? NMFMarker {
                if marker.infoWindow == nil {
                    // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                    self?.dataSource.title = marker.userInfo["title"] as! String
                    self?.infoWindow.open(with: marker)
                } else {
                    // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                    self?.infoWindow.close()
                }
            }
            return true
        }
        testMarker.touchHandler = handler
    }
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        infoWindow.close()
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last, isInitalLocationUpdate else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        // 지도 카메라를 사용자의 현재 위치로 이동
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude))
        cameraUpdate.animation = .easeIn
        
        naverMapView.mapView.moveCamera(cameraUpdate)
        isInitalLocationUpdate = false
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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            // 권한이 없는 경우, 사용자에게 안내
            showAlert(title: "권한 필요", message: "위치 정보 사용을 위한 권한이 필요합니다.")
        }
    }
}
