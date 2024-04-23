//
//  AddPlaceViewController.swift
//  Spacing
//
//  Created by Sam.Lee on 4/22/24.
//

import UIKit

class AddPlaceViewController: UIViewController {
    var address : String = ""
    @IBAction func buttonTouched(_ sender: Any) {
        let vcName = "KakaoPostCodeViewController"
        let storyboard = UIStoryboard(name: vcName, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: vcName) as? KakaoPostCodeViewController else{
            return
        }
        vc.addressDelegate = self
        let destinationViewController = UINavigationController(rootViewController: vc)
        self.present(destinationViewController, animated: true)
    }
    @IBOutlet weak var temp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func showKakaoPostCodeVC() {
        let vcName = "KakaoPostCodeViewController"
        let storyboard = UIStoryboard(name: vcName, bundle: nil)
        let destinationViewController = UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: vcName))
        self.present(destinationViewController, animated: true)
    }
}

extension AddPlaceViewController: AddressDelegate{
    func dataReceived(address: String) {
        print(address)
    }
}
