//
//  SignUpViewController.swift
//  Spacing
//
//  Created by TaeOuk Hwang on 4/23/24.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var newUser: User?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var genderSelectLabel: UILabel!
    
    @IBAction func selectProfileImage(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            profileImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
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
        
        let selectedGender: Gender = genderSegmentedControl.selectedSegmentIndex == 0 ? .Male : .Female
           
        newUser = User(name: name, profileImage: image, email: id, nickName: "", gender: .Male, favorite: [], hostPlace: [], bookPlace: [], isLogin: false)
        
        if let newUser = newUser {
            
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.placeholder = "ID"
        passwordTextField.placeholder = "Password"
        confirmPasswordTextField.placeholder = "Confirm Password"
        nameTextField.placeholder = "Name"
        
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
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
