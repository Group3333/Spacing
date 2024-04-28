//
//  SignUpViewController.swift
//  Spacing
//
//  Created by TaeOuk Hwang on 4/23/24.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController, UINavigationControllerDelegate {
    var newLoginUser: LoginUser?
    let gender : [Gender] =  Gender.allCases
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var seleceProfileImageButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    var image : String = ""
    
    @IBAction func selectProfileImage(_ sender: UIButton) {
        guard let vc = UIStoryboard(name: "ProfileImageSelectViewController", bundle: nil).instantiateViewController(withIdentifier: "ProfileImageSelectViewController") as? ProfileImageSelectViewController else {
            return
        }
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        vc.delegate = self
        present(vc, animated: true)
        
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let nickName = nickNameTextField.text, !nickName.isEmpty,
              let id = idTextField.text, !id.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty,
              let name = nameTextField.text, !name.isEmpty else {
            showAlert(title: "🚨입력 필요🚨", message: "⚠️ 모든 필드를 입력해주세요!")
            return
        }
        
        guard isValidEmail(id) else {
            showAlert(title: "🚨유효하지 않은 이메일🚨", message: "⚠️ 올바른 이메일 주소를 입력해주세요!")
            return
        }
        
        guard isValidPassword(password) else {
            showAlert(title: "🚨유효하지 않은 비밀번호🚨", message: "⚠️ 대소문자 영문과 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요!")
            return
        }
        
        guard password == confirmPassword else {
            showAlert(title: "🚨비밀번호 불일치🚨", message: "⚠️ 비밀번호와 확인 비밀번호가 일치하지 않습니다!")
            return
        }
        
        guard (profileImageView.image?.jpegData(compressionQuality: 1.0)) != nil else {
            showAlert(title: "🚨프로필 이미지 필요🚨", message: "⚠️ 프로필 이미지를 선택해주세요!")
            return
        }
        
        if let _ = UserDefaults.standard.object(forKey: id) as? Data {
            showAlert(title: "🚨중복 회원가입🚨", message: "⚠️ 회원가입이 이미 되어 있습니다!")
            return
        }else{
            newLoginUser = LoginUser(name: name, profileImage: self.image, password: password, email: id, nickName: nickName, gender: gender[genderSegmentedControl.selectedSegmentIndex].rawValue)
            let encoder = JSONEncoder()
            
            /// encoded는 Data형
            if let encoded = try? encoder.encode(newLoginUser) {
                UserDefaults.standard.setValue(encoded, forKey: id)
            }
            let successAlert = UIAlertController(title: "축하합니다!", message: "회원가입이 완료되었습니다!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default) {_ in
                self.dismiss(animated: true)
                self.dismiss(animated: true)
            }
            successAlert.addAction(ok)
            present(successAlert, animated: true, completion: nil)
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        view.backgroundColor = .spacingBeige
        self.hideKeyboardWhenTappedAround()
    }
    
    func configureUI(){
        idTextField.placeholder = "아이디 ( 이메일 형식 )"
        passwordTextField.placeholder = "비밀번호"
        confirmPasswordTextField.placeholder = "비밀번호 확인"
        nameTextField.placeholder = "이름"
        nickNameTextField.placeholder = "닉네임"
        seleceProfileImageButton.setTitle("프로필 변경", for: .normal)
        seleceProfileImageButton.setTitleColor(.spacingOrange, for: .normal)
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = .spacingOrange
        signUpButton.layer.cornerRadius = 10
        genderSegmentedControl.setTitle(gender[0].rawValue, forSegmentAt: 0)
        genderSegmentedControl.setTitle(gender[1].rawValue, forSegmentAt: 1)
        seleceProfileImageButton.sizeToFit()
        [passwordTextField,confirmPasswordTextField].forEach{
            $0?.textContentType = .oneTimeCode
            $0?.isSecureTextEntry = true
        }
        [idTextField,passwordTextField,confirmPasswordTextField,nameTextField,nickNameTextField,genderSegmentedControl].forEach{
            $0?.layer.cornerRadius = 5
        }
//            $0?.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
//            $0?.layer.borderWidth = 2
       
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
//        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.label.cgColor
        profileImageView.tintColor = .label
        profileImageView.image = UIImage(named: "emptyProfile")!
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
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


extension SignUpViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
extension SignUpViewController : ProfileImageDelegate {
    func profileImageChanged(image: String) {
        profileImageView.image = UIImage(named: image)
        self.image = image
    }
}
