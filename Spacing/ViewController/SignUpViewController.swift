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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let id = idTextField.text, !id.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let name = nameTextField.text, !name.isEmpty else {
            return
        }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let newUser = User(context: context)
        newUser.id = id
        newUser.password = password
        newUser.name = name

        do {
            try context.save()
            print("successfully signed up!")
            dismiss(animated: true, completion: nil)
        } catch {
            print("Error saving user: \(error.localizedDescription)")
        }
    }
}
