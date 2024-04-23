//
//  DetailViewController.swift
//  Spacing
//
//  Created by 서혜림 on 4/23/24.
//

import UIKit

class DetailViewController: UIViewController, TimeSelectionDelegate {
    
    // MARK: - Properties
    var price = 0
    var index = -1
    
    var place: Place?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeCateg: UILabel!
    @IBOutlet weak var placeDesc: UILabel!
    @IBOutlet weak var placePrice: UILabel!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.placeName.text = place?.title
        self.placeCateg.text = place?.categories.first?.rawValue ?? "No Category"
        self.placeDesc.text = place?.description
        self.placePrice.text = "\(place?.price ?? 0)원"
    }
    
    // MARK: - IBActions
    
    @IBAction func bookingBtn(_ sender: Any) {
        guard let timeSelectionVC = UIStoryboard(name: "TimeSelectionSB", bundle: nil).instantiateViewController(withIdentifier: "TimeSelectionVC") as? TimeSelectionVC else {
            // 스토리보드에서 TimeSelectionVC를 가져오지 못한 경우
            // 오류 처리 또는 경고 메시지를 표시할 수 있습니다.
            return
        }
        
        timeSelectionVC.modalPresentationStyle = .custom
        timeSelectionVC.transitioningDelegate = self
        timeSelectionVC.delegate = self
        present(timeSelectionVC, animated: true)
    }
    
    func timeSelected(_ hours: Int) {
        print("대여 시간: \(hours)")
        let totalPrice = (place?.price ?? 0) * hours
        placePrice.text = "\(totalPrice)원"
    }
}

extension DetailViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
