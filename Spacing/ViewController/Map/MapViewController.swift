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
    
    var topCategoryList: [Categories] = Categories.allCases
    var place = Place.data
    var locationManager = CLLocationManager()
    var naverMapView = NMFNaverMapView()
    let infoWindow = NMFInfoWindow()
    let dataSource = NMFInfoWindowDefaultTextSource.data()
    var isInitalLocationUpdate = true
    var markers : [NMFMarker] = []
    var ishidden = false
    
    var categoryCollectionView: UICollectionView!
    var detailCollectionView : UICollectionView!
    var searchController : UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        alertLocationAuth()
        setMapUI()
        setCollectionViewUI()
        searchBarConfigure()
        setConstraints()
        setMarker(data: Place.data)
        naverMapView.mapView.touchDelegate = self
        configureBarButton()
        
       
    }
    func configureBarButton(){
        let cancel = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.fill"), style: .plain, target: self, action: #selector(pushMyPage))
        self.navigationItem.rightBarButtonItem = cancel
    }
    @objc func pushMyPage(){
        let storyboard = UIStoryboard(name: "MyPageViewController", bundle: nil)
        let destinationViewController = storyboard.instantiateViewController(withIdentifier: "MyPageViewController") as! MyPageViewController
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    func setMapUI() {
        self.view.addSubview(naverMapView)
        
        naverMapView.mapView.positionMode = .normal
        naverMapView.showLocationButton = true
    }
    func searchBarConfigure(){
        searchController = UISearchBar()
        searchController.placeholder = "이름, 주소 등"
        searchController.searchTextField.backgroundColor = .spacingBeige
        searchController.delegate = self
        self.navigationItem.titleView = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setCollectionViewUI() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = 30
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        let flowLayout2 = UICollectionViewFlowLayout()
        flowLayout2.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout2.minimumLineSpacing = 30
        flowLayout2.minimumInteritemSpacing = 0
        flowLayout2.scrollDirection = .horizontal
        // 실제 컬렉션 뷰의 프레임이 아닌 적절한 크기를 설정해야 합니다.
        categoryCollectionView = {
            flowLayout.itemSize = CGSize(width: 40 * 2.5, height: 40)
            let cv = UICollectionView(frame: .zero,collectionViewLayout: flowLayout)
            cv.delegate = self
            cv.dataSource = self
            cv.register(TopCollectionViewCell.nib(), forCellWithReuseIdentifier: TopCollectionViewCell.identifier)
            return cv
        }()
        
        detailCollectionView = {
            flowLayout2.itemSize = CGSize(width: 150 * 2.5, height: 150)
            let cv = UICollectionView(frame: .zero,collectionViewLayout: flowLayout2)
            cv.delegate = self
            cv.dataSource = self
            cv.register(PlaceCollectionViewCell.nib(), forCellWithReuseIdentifier: PlaceCollectionViewCell.identifier)
            return cv
        }()
        
        [detailCollectionView!,categoryCollectionView!].forEach{
            $0.backgroundColor = .clear
            $0.allowsMultipleSelection = false
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.decelerationRate = UIScrollView.DecelerationRate.fast
            naverMapView.addSubview($0)
        }
        detailCollectionView.isPagingEnabled = false
        
    }
    
    func setConstraints() {
        
        naverMapView.translatesAutoresizingMaskIntoConstraints = false
        
        naverMapView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        naverMapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        naverMapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        naverMapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        categoryCollectionView.snp.makeConstraints {make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        detailCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
            make.height.equalTo(150)
        }
    }
    func alertLocationAuth() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func setMarker(data : [Place]) {
        for place in data {
            let testMarker = NMFMarker()
            testMarker.position = NMGLatLng(lat: place.lat, lng: place.lng)
            testMarker.captionText = place.title
            testMarker.userInfo = ["title" : place.title]
            testMarker.mapView = naverMapView.mapView // 지도상에 마커를 나타냄
            
            infoWindow.dataSource = dataSource
            infoWindow.alpha = 0.8
            
            let handler = { [weak self] (overlay: NMFOverlay) -> Bool in
                if let marker = overlay as? NMFMarker {
                    if marker.infoWindow == nil {
                        // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                        self?.dataSource.title = marker.userInfo["title"] as! String
                        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: place.lat, lng: place.lng), zoomTo: 14)
                        cameraUpdate.animation = .fly
                        cameraUpdate.animationDuration = 3
                        self?.naverMapView.mapView.moveCamera(cameraUpdate)
                        self?.infoWindow.open(with: marker)
                        self?.toggleDetails()
                    } else {
                        // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                        self?.infoWindow.close()
                    }
                }
                return true
            }
            testMarker.touchHandler = handler
            markers.append(testMarker)
        }
    }
    
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        infoWindow.close()
        toggleDetails()
    }
    
    func toggleDetails(){
        if self.ishidden { // TableView가 아래로 스크롤될 때
            self.detailCollectionView.snp.remakeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(30)
                make.height.equalTo(150)
            }
            ishidden.toggle()
        } else {
            self.detailCollectionView.snp.remakeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(200)
                make.height.equalTo(150)
            }
            ishidden.toggle()
        }
        UIView.animate(withDuration: 0.4) {
            
            self.view.layoutIfNeeded()
        }
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
extension MapViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == detailCollectionView{
            return place.count
        }else{
            return topCategoryList.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == detailCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCollectionViewCell.identifier, for: indexPath) as? PlaceCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(place : place[indexPath.row])
            cell.backgroundColor = UIColor.systemBackground
            cell.layer.cornerRadius = 20
            cell.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
            cell.layer.borderWidth = 2
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCollectionViewCell.identifier, for: indexPath) as? TopCollectionViewCell else {
                return UICollectionViewCell()
            }
            let cat = topCategoryList[indexPath.row]
            cell.configure(title: cat.rawValue, image: Place.categoryImage[cat]!)
            cell.backgroundColor = UIColor.systemBackground
            cell.layer.cornerRadius = 20
            cell.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
            cell.layer.borderWidth = 2
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let selectedCategory = topCategoryList[indexPath.row]
            for marker in markers{
                marker.mapView  = nil
            }
            markers.removeAll()
            
            let filteredPlace = {
                if selectedCategory == .all{
                    return Place.data
                }else{
                    return Place.data.filter{$0.categories == selectedCategory}
                }
            }()
            self.place = filteredPlace
            if !place.isEmpty {
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: place[0].lat, lng: place[0].lng), zoomTo: 14)
                cameraUpdate.animation = .fly
                cameraUpdate.animationDuration = 3
                self.naverMapView.mapView.moveCamera(cameraUpdate)
                setMarker(data: filteredPlace)
            }else{
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.44910833 , lng: 126.9041972), zoomTo: 5)
                cameraUpdate.animation = .fly
                cameraUpdate.animationDuration = 3
                self.naverMapView.mapView.moveCamera(cameraUpdate)
            }
            detailCollectionView.reloadData()
            
        }
        else{
            let currentPlace = place[indexPath.row]
            let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
            let destinationViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            destinationViewController.selectedPlaces = currentPlace
            self.navigationController?.pushViewController(destinationViewController, animated: true)
        }
        
    }
    
}


extension MapViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Ensure that the scrolling view is the one you want to apply paging to
        if scrollView == detailCollectionView {
            // item의 사이즈와 item 간의 간격 사이즈를 구해서 하나의 item 크기로 설정.
            let layout = self.detailCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
            
            // targetContentOffset을 이용하여 x좌표가 얼마나 이동했는지 확인
            // 이동한 x좌표 값과 item의 크기를 비교하여 몇 페이징이 될 것인지 값 설정
            var offset = targetContentOffset.pointee
            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
            let roundedIndex = round(index)
            
            // 중앙에 보이도록 offset을 조절
            let centeredOffsetX = (roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left) - (scrollView.bounds.width - cellWidthIncludingSpacing) / 2
            offset = CGPoint(x: centeredOffsetX, y: -scrollView.contentInset.top)
            targetContentOffset.pointee = offset
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Ensure that the scrolling view is the one you want to apply paging to
        if scrollView == detailCollectionView {
            let layout = self.detailCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
            let index = round((scrollView.contentOffset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing)
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: place[Int(index)].lat, lng: place[Int(index)].lng), zoomTo: 14)
            cameraUpdate.animation = .fly
            cameraUpdate.animationDuration = 3
            self.naverMapView.mapView.moveCamera(cameraUpdate)
        }
    }
}

    extension MapViewController :UISearchBarDelegate {
        
    }
