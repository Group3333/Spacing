//
//  AppDelegate.swift
//  Spacing
//
//  Created by Sam.Lee on 4/22/24.
//

// AppDelegate.swift
import UIKit
import CoreData
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let context = persistentContainer.viewContext
        
        let user = IDEntity(context: context)
        user.id = "admin@naver.com"
        user.password = "admin1234"
        user.name = "test admin"
        
        saveContext()
        
        IQKeyboardManager.shared.enable = true
        return true
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Spacing")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
