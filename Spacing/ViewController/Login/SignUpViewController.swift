//
//  SignUpViewController.swift
//  Spacing
//
//  Created by TaeOuk Hwang on 4/23/24.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let id = idTextField.text, !id.isEmpty,
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

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<IDEntity> = IDEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let users = try context.fetch(fetchRequest)
            if !users.isEmpty {
                showAlert(title: "🚨이미 등록된 아이디🚨", message: "⚠️ 해당 아이디로 이미 회원가입이 되어 있습니다!")
                return
            }
        } catch {
            return
        }

        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let users = try context.fetch(fetchRequest)
            if !users.isEmpty {
                showAlert(title: "🚨이미 등록된 이름🚨", message: "⚠️ 해당 이름으로 이미 회원가입이 되어 있습니다!")
                return
            }
        } catch {
            return
        }

        let newUser = IDEntity(context: context)
        newUser.id = id
        newUser.password = password
        newUser.name = name

        do {
            try context.save()
            print("successfully signed up!")
            dismiss(animated: true, completion: nil)
        } catch {
            return
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
