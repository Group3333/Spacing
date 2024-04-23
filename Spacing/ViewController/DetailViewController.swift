//
//  DetailViewController.swift
//  Spacing
//
//  Created by 서혜림 on 4/23/24.
//

import UIKit

class HalfModalPresentationController: UIPresentationController {
    // 하프 모달의 뒤 배경 뷰
    private var dimmingView: UIView!
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return CGRect.zero }
        
        let height: CGFloat = 300 // 하프 모달의 높이
        return CGRect(x: 0, y: containerView.bounds.height - height, width: containerView.bounds.width, height: height)
    }
    
    // 모달이 표시될 때 호출되는 메서드
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        // 어둡게 처리할 배경 뷰 생성
        dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5) // 어둡게 처리할 배경의 투명도 조절
        dimmingView.alpha = 0 // 초기에는 보이지 않도록 설정
        containerView.insertSubview(dimmingView, at: 0)
        
        // 애니메이션을 사용하여 배경 뷰를 어둡게 표시
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1 // 어둡게 처리할 배경의 투명도를 1로 변경하여 보이도록 함
        }, completion: nil)
        
        // 모달의 모서리를 둥글게 만듦
        presentedViewController.view.layer.cornerRadius = 12
        presentedViewController.view.clipsToBounds = true
    }
    
    // 모달이 사라질 때 호출되는 메서드
    override func dismissalTransitionWillBegin() {
        // 애니메이션을 사용하여 배경 뷰를 다시 투명하게 만듦
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0 // 어둡게 처리할 배경의 투명도를 0으로 변경하여 숨김
        }, completion: { _ in
            // 애니메이션 완료 후 배경 뷰를 제거
            self.dimmingView.removeFromSuperview()
        })
    }
}

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
