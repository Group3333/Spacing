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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let id = idTextField.text, !id.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("ID or password is empty")
            
            return
        }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id == %@ AND password == %@", id, password)

        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                performSegue(withIdentifier: "TestView", sender: nil)

                print("Login successful for user: \(String(describing: user.name))")
            } else {
                print("Please try again.")
            }
        } catch {
            print("Error")
        }
    }
}
