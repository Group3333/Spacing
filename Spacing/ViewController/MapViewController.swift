//
//  MapViewController.swift
//  Spacing
//
//  Created by 최진문 on 2024/04/22.
//

import UIKit
import NMapsMap
import CoreLocation

class MapViewController: UIViewController, NMFMapViewTouchDelegate {
    
    var topCategoryList: [String] = ["카페", "갤러리", "독립오피스", "스터디룸", "촬영스튜디오", "파티룸"]
    var bottomThumbnail: [String] = ["테스트입니다"]
    
    var locationManager = CLLocationManager()
    var naverMapView = NMFNaverMapView()
    var marker = NMFMarker()
    let infoWindow = NMFInfoWindow()
    let dataSource = NMFInfoWindowDefaultTextSource.data()
    var isInitalLocationUpdate = true
    
    lazy var topCategoryCollectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: topCategoryCollectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var bottomCollectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: bottomCollectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let topCategoryCollectionViewLayout: UICollectionViewFlowLayout = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.minimumLineSpacing = 30
        flowlayout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        return flowlayout
    }()
    
    let bottomCollectionViewLayout: UICollectionViewFlowLayout = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.minimumLineSpacing = 30
        flowlayout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        return flowlayout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        alertLocationAuth()
        setMapUI()
        setCollectionViewUI()
        setConstraints()
        setMarker()
        naverMapView.mapView.touchDelegate = self
    }
    
    func setMapUI() {
        self.view.addSubview(naverMapView)
        
        naverMapView.mapView.positionMode = .normal
        naverMapView.showLocationButton = true
    }
    
    func setCollectionViewUI() {
        naverMapView.addSubview(topCategoryCollectionView)
        naverMapView.addSubview(bottomCollectionView)
        
        topCategoryCollectionView.delegate = self
        topCategoryCollectionView.dataSource = self
        topCategoryCollectionView.register(TopCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "TopCategoryCollectionViewCell")
        
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        bottomCollectionView.register(BottomCollectionViewCell.self, forCellWithReuseIdentifier: "BottomCollectionViewCell")
    }
    func setConstraints() {
        
        naverMapView.translatesAutoresizingMaskIntoConstraints = false
        
        naverMapView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        naverMapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        naverMapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        naverMapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        topCategoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        topCategoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topCategoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topCategoryCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        bottomCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        bottomCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        bottomCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        bottomCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func alertLocationAuth() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func setMarker() {
        let testMarker = marker
        testMarker.position = NMGLatLng(lat: 35.154497, lng: 129.019168)
        testMarker.mapView = naverMapView.mapView // 지도상에 마커를 나타냄
        
        dataSource.title = "테스트 마커의 정보창"
        infoWindow.dataSource = dataSource
        
        let handler = { [weak self] (overlay: NMFOverlay) -> Bool in
            if let marker = overlay as? NMFMarker {
                if marker.infoWindow == nil {
                    // 현재 마커에 정보 창이 열려있지 않을 경우 엶
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

extension MapViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == topCategoryCollectionView {
                return topCategoryList.count
            } else {
                return bottomThumbnail.count
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topCategoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCategoryCollectionViewCell", for: indexPath) as? TopCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.categoryText.text = topCategoryList[indexPath.row]
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomCollectionViewCell", for: indexPath) as? BottomCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.bottomText.text = bottomThumbnail[indexPath.row]
            return cell
        }
    }
    
}
