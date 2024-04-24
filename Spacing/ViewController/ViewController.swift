//
//  ViewController.swift
//  Spacing
//
//  Created by Sam.Lee on 4/22/24.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
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
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id == %@ AND password == %@", id, password)
        
        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                performSegue(withIdentifier: "testview", sender: nil)
                print("Login successful for user: \(String(describing: user.name))")
            } else {
                showAlert(title: "🚨Login 실패🚨", message: "⚠️ 다시 시도해주세요!")
            }
        } catch {
            print("Error")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.placeholder = "ID"
        passwordTextField.placeholder = "Password"
        
        passwordTextField.isSecureTextEntry = true
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
