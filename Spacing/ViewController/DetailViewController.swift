//
//  DetailViewController.swift
//  Spacing
//
//  Created by 서혜림 on 4/23/24.
//

import SwiftUI

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
        self.placeCateg.text = place?.categories.first?.rawValue ?? "No Category" // 카테고리가 비어있는 경우 안전하게 처리
        self.placeDesc.text = place?.description
        self.placePrice.text = "\(place?.price ?? 0)원" // 가격 정보 추가, 가격이 없을 경우 0으로 표시
    }
    
    // MARK: - IBActions
    
    @IBAction func bookingBtn(_ sender: Any) {
        guard let timeSelectionVC = UIStoryboard(name: "TimeSelectionSB", bundle: nil).instantiateViewController(withIdentifier: "TimeSelectionVC") as? TimeSelectionVC else {
            // 스토리보드에서 TimeSelectionVC를 가져오지 못한 경우
            // 오류 처리 또는 경고 메시지를 표시할 수 있습니다.
            return
        }
        
        timeSelectionVC.modalPresentationStyle = .fullScreen
        timeSelectionVC.delegate = self // 델리게이트 연결
        present(timeSelectionVC, animated: true)
        
        
    }
    
    func timeSelected(_ hours: Int) {
           print("대여 시간: \(hours)")
           let totalPrice = (place?.price ?? 0) * hours
           placePrice.text = "\(totalPrice):원"
       }
}
