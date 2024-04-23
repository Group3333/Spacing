//
//  DetailViewController.swift
//  Spacing
//
//  Created by 서혜림 on 4/23/24.
//

import UIKit

class DetailViewController: UIViewController, TimeSelectionDelegate {
    
    // MARK: - Properties
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
        bookingAlert()
    }
    
    // MARK: - Methods
    
    private func configureUI() {
            placeName.text = place?.title ?? "A"
            placeCateg.text = place?.categories.first?.rawValue ?? "No Category"
            placeDesc.text = place?.description ?? "B"
            placePrice.text = "\(place?.price ?? 0)원"
            [placeName, placeCateg, placeDesc, placePrice].forEach { $0?.sizeToFit() }
        }
    
    func timeSelected(_ hours: Int) {
        print("대여 시간: \(hours)")
        let totalPrice = (place?.price ?? 0) * hours
        placePrice.text = "\(totalPrice)원"
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
