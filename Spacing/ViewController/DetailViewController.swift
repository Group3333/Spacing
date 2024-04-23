//
//  DetailViewController.swift
//  Spacing
//
//  Created by 서혜림 on 4/23/24.
//

import SwiftUI

class DetailViewController: UIViewController {
    
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
        self.placeCateg.text = place?.categories[0].rawValue // 문자열로 변환?
        self.placeDesc.text = place?.description
//        self.placePrice.text = place?. // 가격 추가
        
    }

    // MARK: - IBActions
    
    @IBAction func bookingBtn(_ sender: Any) {
//        let NextStoryboard = UIStoryboard (name: "NextStoryboard", bundle: .main)
//        let NextVC = NextStoryboard.instantiateViewController (withIdentifier: "NextVC") as! NextVC
//        NextVC.place = self.place
//        
//        self.navigationController?.pushViewController(NextVC, animated: true)
    }
    
}
