//
//  MainTabBarController.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 28/06/2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    func setupUser() -> [User] {
        var resultArray = [User]()
        
        let firstPhotoArray = [UIImage(named: "pok1")!, UIImage(named: "pok2")!, UIImage(named: "pok3")!, UIImage(named: "pok4")!, UIImage(named: "pok5")!]
        let firstUser = User(name: "Bulbasaur", avatar: UIImage(named: "bulbasaur")!, photoArray: firstPhotoArray)
        resultArray.append(firstUser)
        
        let secondPhotoArray = [UIImage(named: "ork1")!, UIImage(named: "orc2")!, UIImage(named: "orc3")!, UIImage(named: "orc4")!, UIImage(named: "orc5")!]
        let secondUser = User(name: "Orc Denis", avatar: UIImage(named: "orc5")!, photoArray: secondPhotoArray)
        resultArray.append(secondUser)
        
        let thirdPhotoArray = [UIImage(named: "groot1")!, UIImage(named: "groot2")!, UIImage(named: "groot3")!, UIImage(named: "groot4")!, UIImage(named: "groot5")!]
        let thirdUser = User(name: "Groot", avatar: UIImage(named: "groot4")!, photoArray: thirdPhotoArray)
        resultArray.append(thirdUser)
        
        return resultArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let friendsNavigationController = self.viewControllers?.first as? UINavigationController,
           let friendsViewController = friendsNavigationController.viewControllers.first as? FriendsViewController {
            friendsViewController.configure(userArray: setupUser())
            }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
