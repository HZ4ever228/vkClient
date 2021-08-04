//
//  FriendsViewController.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 24/06/2021.
//

import UIKit

class FriendsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let reuseIdentifierUniversalTableCell =  "reuseIdentifierUniversalTableCell"
    let segueToPhotoController = "fromFriendsToPhoto"
    
    var friendsArray = [User]()
    var searchFriendsArray = [User]()
    var searchFlag = false
    
    func configure(userArray: [User]) {
        self.friendsArray = userArray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "UniversalTableCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalTableCell)
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func myFriendsArray() -> [User] {
        if searchFlag {
            return searchFriendsArray
        }
        return friendsArray
    }
    
    func arrayLetters() -> [String] {
        var resultArray = [String]()
        for item in myFriendsArray() {
            let nameLetter = String(item.name.prefix(1))
            if !resultArray.contains(nameLetter) {
                resultArray.append(nameLetter)
            }
        }
        return resultArray
    }
    
    func arrayByLetter(letter: String) -> [User] {
        var resultArray = [User]()
        for item in myFriendsArray() {
            let nameLetter = String(item.name.prefix(1))
            if nameLetter == letter {
                resultArray.append(item)
            }
        }
        return resultArray
    }
    
    func animatedChoose() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.2
        animation.toValue = 1.5
        animation.stiffness = 70
        animation.mass = 1
        animation.duration = 1
        self.tableView.layer.add(animation, forKey: nil)
    }
}

extension FriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searchFlag = false
        }
        else {
            searchFlag = true
            searchFriendsArray = friendsArray.filter({
                item in item.name.lowercased().contains(searchText.lowercased())
            })
        }
        tableView.reloadData()
    }
}
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayLetters().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayByLetter(letter: arrayLetters()[section]).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalTableCell, for: indexPath) as? UniversalTableCell else { return UITableViewCell() }
        //cell.configure(title: friendsArray[indexPath.row].name, image: friendsArray[indexPath.row].avatar)
        let arrayByLetterItems = arrayByLetter(letter: arrayLetters()[indexPath.section])
        cell.configure(user: arrayByLetterItems[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToPhotoController,
            let dst = segue.destination as? PhotoController,
                let user = sender as? User {
            animatedChoose()
            dst.photoArray = user.photoArray
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        guard let cell = tableView.cellForRow(at: indexPath) as? UniversalTableCell,
              let cellObject = cell.savedObject as? User else {return }
        performSegue(withIdentifier: segueToPhotoController, sender: cellObject)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayLetters()[section].uppercased()
    }
}
