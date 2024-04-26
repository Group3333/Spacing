//
//  ViewController.swift
//  Spacing
//
//  Created by Sam.Lee on 4/22/24.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let id = idTextField.text, !id.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "🚨입력 필요🚨", message: "⚠️ ID와 Password를 모두 입력해주세요!")
            return
        }
        
        guard isValidEmail(id) else {
            showAlert(title: "🚨ID 입력 오류🚨", message: "⚠️ 유효한 이메일 형식을 입력해주세요!")
            return
        }
        
        guard isValidPassword(password) else {
            showAlert(title: "🚨Password 입력 오류🚨", message: "⚠️ 대소문자 영문과 숫자를 포함한 8자 이상의 Password를 입력해주세요!")
            return
        }
        
        if let savedData = UserDefaults.standard.object(forKey: id) as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode(LoginUser.self, from: savedData) {
                guard savedObject.password == password else {
                    showAlert(title: "🚨Password 오류🚨", message: "⚠️ Password가 일치하지 않습니다!")
                    return
                }
                User.currentUser.name = savedObject.name
                User.currentUser.email = savedObject.email
                User.currentUser.gender = Gender(rawValue: savedObject.gender)!
                User.currentUser.profileImage = UIImage(named: savedObject.profileImage)!
                User.currentUser.isLogin = true
//                let destinationViewController =  UIStoryboard(name: "MyPageViewController", bundle: nil).instantiateInitialViewController()!
                
                self.navigationController?.pushViewController(MapViewController(), animated: true)
            }
        }else{
            showAlert(title: "🚨회원정보 없음!🚨", message: "⚠️ 해당 회원정보를 찾을 수 없습니다!")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.placeholder = "아이디 ( 이메일 형식 )"
        passwordTextField.placeholder = "비밀번호"
        
        passwordTextField.isSecureTextEntry = true
        
//        if let appDomain = Bundle.main.bundleIdentifier {
//            UserDefaults.standard.removePersistentDomain(forName: appDomain)
//        }
    }
    
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    func isValidEmail(_ id: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: id)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
