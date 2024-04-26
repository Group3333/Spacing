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

class MapViewController: UIViewController, NMFMapViewTouchDelegate, UICollectionViewDelegate {
    
    var locationManager = CLLocationManager()
    var naverMapView = NMFNaverMapView()
    let dataSource = NMFInfoWindowDefaultTextSource.data()
    var isInitalLocationUpdate = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertLocationAuth()
        setMapUI()
        setConstraints()
        for place in Place.data {
            setMarker(lat: place.lat, lng: place.lng, title: place.title)
        }
        naverMapView.mapView.touchDelegate = self
    }
    
    func setMapUI() {
        self.view.addSubview(naverMapView)
        
        naverMapView.mapView.positionMode = .normal
        naverMapView.showLocationButton = true
    }
    
    func setConstraints() {
        naverMapView.translatesAutoresizingMaskIntoConstraints = false
        naverMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func alertLocationAuth() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func setMarker(lat : Double, lng: Double, title : String) {
        let testMarker = NMFMarker()
        let infoWindow = NMFInfoWindow()
        
        testMarker.position = NMGLatLng(lat: lat, lng: lng)
        testMarker.captionText = title
        testMarker.userInfo = ["title" : title]
        testMarker.iconImage = NMF_MARKER_IMAGE_BLACK
        testMarker.iconTintColor = UIColor.spacingOrange
        testMarker.mapView = naverMapView.mapView // 지도상에 마커를 나타냄
        
        infoWindow.dataSource = CustomInfoWindowDataSource(title: title)
        infoWindow.alpha = 0.8
        
        let handler = { [weak self] (overlay: NMFOverlay) -> Bool in
            if let marker = overlay as? NMFMarker {
                if marker.infoWindow == nil {
                    // 현재 마커를 터치하면 실행되는 코드블럭
//                    self?.dataSource.title = marker.userInfo["title"] as! String
                    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng), zoomTo: 14)
                    cameraUpdate.animation = .easeIn
                    self?.naverMapView.mapView.moveCamera(cameraUpdate)
                    infoWindow.open(with: marker)
                } else {
                    infoWindow.close()
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

class CustomInfoWindowDataSource: NSObject, NMFOverlayImageDataSource {
    var title: String = ""
    init(title: String) {
        self.title = title
    }
    func view(with overlay: NMFOverlay) -> UIView {
        let label = UILabel()
        label.text = self.title
        label.backgroundColor = .white
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10)  // 글자 크기 설정
        label.textAlignment = .center
        label.numberOfLines = 0
        label.frame = CGRect(x: 0, y: 0, width: 150, height: 50)  // 정보창 크기 설정
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5
        label.clipsToBounds = true

        return label
    }
}
