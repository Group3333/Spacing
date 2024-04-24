//
//  MyPageViewController.swift
//  Spacing
//
//  Created by Sam.Lee on 4/22/24.
//

import UIKit

class MyPageViewController: UIViewController{
    
    
    var user = User.currentUser
    let section = ["profile", "menus", "button"]
    @IBOutlet weak var myPageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    func configure(){
        
        self.myPageTableView.dataSource = self
        self.myPageTableView.delegate = self
        self.myPageTableView.register(UserTableViewCell.nib(), forCellReuseIdentifier: UserTableViewCell.identifier)
        self.myPageTableView.register(MenuTableViewCell.nib(), forCellReuseIdentifier: MenuTableViewCell.identifier)
        self.myPageTableView.register(ButtonTableViewCell.nib(), forCellReuseIdentifier: ButtonTableViewCell.identifier)
        
        self.navigationItem.title = "마이 페이지"
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(PresentAddPlaceVC))
        addButton.tintColor = .red
        self.navigationItem.rightBarButtonItem = addButton
    }
    @objc func PresentAddPlaceVC (){
        let storyboard = UIStoryboard(name: "AddPlaceViewController", bundle: nil)
        let destinationViewController = storyboard.instantiateViewController(withIdentifier: "AddPlaceViewController")
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

extension MyPageViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section{
        case 1:
            let vcName = MyPageMenu.menus[indexPath.row].detailVC
            let storyboard = UIStoryboard(name: vcName, bundle: nil)
            let destinationViewController = storyboard.instantiateViewController(withIdentifier: vcName)
            guard let vc = destinationViewController as? PlaceViewController else{
                return
            }
            vc.state = MyPageMenu.menus[indexPath.row].state
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("Selected row \(indexPath.row) in section \(indexPath.section)")
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 1:
            return MyPageMenu.menus.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(user: User.currentUser)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as? MenuTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(menu: MyPageMenu.menus[indexPath.row])
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identifier, for: indexPath) as? ButtonTableViewCell else {
                return UITableViewCell()
            }
            cell.configure()
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0 :
            return 200
        case 1:
            return 50
        case 2:
            return 80
        default:
            return 100
        }
    }
}
