//
//  DetailViewController.swift
//  Spacing
//
//  Created by 서혜림 on 4/23/24.
//

import UIKit
protocol FavoritieDelegate{
    func favChanged()
}
class DetailViewController: UIViewController, TimeSelectionDelegate {
    
    // MARK: - Properties
    
    // var place : Place?
    let categories: [Categories] = Categories.allCases
    var selectedCategory: Categories = .all
    var selectedPlaces: Place = Place.data[0]
    var isFav : Bool = false
    var delegate : FavoritieDelegate?
    var hours : Int = 0
    
    // MARK: - IBOutlets
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var placeImage: UICollectionView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeCateg: UILabel!
    @IBOutlet weak var placeDescription: UITextView!
    @IBOutlet weak var placePrice: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    // MARK: - Lifecycle
    
    @IBAction func favButtonClicked(_ sender: Any) {
        isFav = isFav ? false : true
        if isFav {
            self.favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            User.currentUser.favorite.append(selectedPlaces)
        }else{
            self.favButton.setImage(UIImage(systemName: "star"), for: .normal)
            User.currentUser.favorite.removeAll{$0.title == selectedPlaces.title && $0.description == selectedPlaces.description && $0.position == selectedPlaces.position}
        }
        self.delegate?.favChanged()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - IBActions
    
    @IBAction func timeSelectBtn(_ sender: Any) {
        guard let timeSelectionVC = UIStoryboard(name: "TimeSelectionSB", bundle: nil).instantiateViewController(withIdentifier: "TimeSelectionVC") as? TimeSelectionVC else {
            return
        }
        timeSelectionVC.modalPresentationStyle = .custom
        timeSelectionVC.transitioningDelegate = self
        timeSelectionVC.delegate = self
        present(timeSelectionVC, animated: true)
    }
    
    @IBAction func bookingBtn(_ sender: Any) {
        let temp = Int(self.hours / 3 )
        let remain = self.hours - (temp * 3)
        let totalPrice = (selectedPlaces.price - Place.hourDiscount) * remain + temp * (selectedPlaces.price * 3 - Place.eventDiscount)
        
        // BookPlace 인스턴스 생성 및 값 할당
        let bookPlace = BookPlace(place: selectedPlaces, time: self.hours, totalPrice: totalPrice)
        bookingAlert(bookPlace: bookPlace)
    }

    func bookingAlert(bookPlace: BookPlace) {
        let bookingAlert = UIAlertController(title: nil, message: "예약이 완료되었습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            // 확인 버튼을 누르면 수행할 작업
        }
        bookingAlert.addAction(ok)
        User.currentUser.bookPlace.append(bookPlace)
        // 예약된 자리 정보를 전달합니다.
        present(bookingAlert, animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    private func configureUI() {
        isFav =  User.currentUser.favorite.contains(where: {$0.title == selectedPlaces.title && $0.description == selectedPlaces.description}) ? true : false
        
        isFav ? favButton.setImage(UIImage(systemName: "star.fill"), for: .normal) : favButton.setImage(UIImage(systemName: "star"), for: .normal)

        placeName.text = selectedPlaces.title
        placeCateg.text = selectedPlaces.categories.rawValue
        placeDescription.text = selectedPlaces.description
        rateLabel.attributedText = makeStarLabel(rating: selectedPlaces.rating)
        placePrice.text = "\(Int.addCommas(to: selectedPlaces.price - Place.hourDiscount)) 원"
        originalPriceLabel.text = "\(Int.addCommas(to: selectedPlaces.price)) 원"
        originalPriceLabel.attributedText = originalPriceLabel.text?.strikeThrough()
        timeLabel.text = "1 시간"
        [placeName, placeCateg, placePrice].forEach { $0?.sizeToFit() }

        pageControl.numberOfPages = selectedPlaces.images.count
        pageControl.pageIndicatorTintColor = UIColor.systemGray
        pageControl.currentPageIndicatorTintColor = UIColor.label
        
        configureCollectionView()
    }


    
    func configureCollectionView() {
        placeImage.dataSource = self
        placeImage.delegate = self
        placeImage.register(ImageCollectionViewCell.nib(), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: Int(placeImage.frame.size.width), height: Int(placeImage.frame.size.height))
        placeImage.collectionViewLayout = flowLayout
        placeImage.allowsMultipleSelection = false
    }
    
    func makeStarLabel(rating : Double) -> NSMutableAttributedString{
        let attributeString = NSMutableAttributedString(string: "")
        
        // 별 이미지를 추가합니다.
        let fullStarCount = Int(rating)
        for _ in 0..<fullStarCount {
            let imageAttachment = NSTextAttachment(image: UIImage(systemName: "star.fill")!)
            imageAttachment.bounds = .init(x: 0, y: -2, width: 14, height: 14)
            attributeString.append(NSAttributedString(attachment: imageAttachment))
        }
        
        // 소수점 이하의 값을 반올림하여 추가합니다.
        let remainingRating = rating - Double(fullStarCount)
        if remainingRating > 0 {
            let imageAttachment = NSTextAttachment(image: UIImage(systemName: "star.leadinghalf.fill")!)
            imageAttachment.bounds = .init(x: 0, y: -2, width: 14, height: 14)
            attributeString.append(NSAttributedString(attachment: imageAttachment))
        }
        
        // 나머지 빈 별을 추가합니다.
        let emptyStarCount = 5 - fullStarCount - (remainingRating > 0 ? 1 : 0)
        for _ in 0..<emptyStarCount {
            let imageAttachment = NSTextAttachment(image: UIImage(systemName: "star")!)
            imageAttachment.bounds = .init(x: 0, y: -2, width: 14, height: 14)
            attributeString.append(NSAttributedString(attachment: imageAttachment))
        }
        attributeString.append(NSAttributedString(string: " \(rating)"))
        return attributeString
    }
    func timeSelected(_ hours: Int) {
        self.hours = hours
        let temp = Int(hours / 3 )
        let remain = hours - (temp * 3)
        let totalPrice = (selectedPlaces.price - Place.hourDiscount) * remain + temp * (selectedPlaces.price * 3 - Place.eventDiscount)
        
        placePrice.text = "\(Int.addCommas(to: totalPrice)) 원"
        timeLabel.text = "\(hours) 시간"
        originalPriceLabel.text = "\(Int.addCommas(to: hours * selectedPlaces.price)) 원"
        originalPriceLabel.attributedText = originalPriceLabel.text?.strikeThrough()
    }
    
    func bookingAlert() {
        let bookingAlert = UIAlertController(title: nil, message: "예약이 완료되었습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) {_ in
            self.dismiss(animated: true)
        }
        bookingAlert.addAction(ok)
        present(bookingAlert, animated: true, completion: nil)
    }
}

extension DetailViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: - UICollectionViewDataSource , UICollectionViewDelegateFlowLayout

extension DetailViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedPlaces.images.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
            cell.configure(image: selectedPlaces.images[indexPath.row])
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / self.placeImage.frame.width)
        self.pageControl.currentPage = page
    }
    
}
