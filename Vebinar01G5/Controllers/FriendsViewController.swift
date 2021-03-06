//
//  FriendsViewController.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 24/06/2021.
//

import UIKit
import RealmSwift
import SwiftUI

class FriendsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let segueToPhotoController = "fromFriendsToPhoto"
    
    private var realm = try! Realm()

    let reuseIdentifierUniversalTableCell =  "reuseIdentifierUniversalTableCell"
    
    var friendsArray = [User]()

    var searchFriendsArray = [User]()
    var searchFlag = false

    var databaseNotificationToken: NotificationToken?
    var resultNotificationToken: NotificationToken?


    //MARK: - Life Cicle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "UniversalTableCell", bundle: nil),
                                forCellReuseIdentifier: reuseIdentifierUniversalTableCell)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        setupUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationsObserve(users: realm.objects(User.self))
        
    }

    //MARK: - Actions
    
    func setupUser(){
        self.activityIndicator.startAnimating()
        DataRepository.shared.getFriends(completion: { error, users in
            if error == nil, let userArray = users {
                self.friendsArray = userArray
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
    
    func notificationsObserve(users: Results<User>) {
        resultNotificationToken = users.observe { change in
            switch change{
            case .initial:
                print("init")
            case .update(_, let deletions, let insertions, let modifications):
                print(deletions)
                print(insertions)
                print(modifications)
            case .error(let error):
                print(error)
            }
        }
        
        databaseNotificationToken = realm.observe { notification, realm in
            print(notification.rawValue)
            print(realm.objects(User.self))
        }
    }


    //MARK:- animatedChoose of cell

    func animatedChoose() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.2
        animation.toValue = 1.5
        animation.stiffness = 70
        animation.mass = 1
        animation.duration = 1
        self.tableView.layer.add(animation, forKey: nil)
    }

    //MARK:- ArrayByLetters
    
    func myFriendsArray() -> [User] {
        if searchFlag {
            return searchFriendsArray
        }
        return friendsArray
    }
    
    func arrayLetters() -> [String] {
        var resultArray = [String]()
        for item in myFriendsArray() {
            let nameLetter = String(item.first_name.prefix(1))
            if !resultArray.contains(nameLetter) {
                resultArray.append(nameLetter)
            }
        }
        return resultArray
    }
    
    func arrayByLetter(letter: String) -> [User] {
        var resultArray = [User]()
        for item in myFriendsArray() {
            let nameLetter = String(item.first_name.prefix(1))
            if nameLetter == letter {
                resultArray.append(item)
            }
        }
        return resultArray
    }
}

//MARK:- searchBar

extension FriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searchFlag = false
        }
        else {
            searchFlag = true
            searchFriendsArray = friendsArray.filter({
                item in item.first_name.lowercased().contains(searchText.lowercased()) ||
                    item.last_name.lowercased().contains(searchText.lowercased())
            })
        }
        tableView.reloadData()
    }
}

//MARK: - Extension UITableView -

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayLetters().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayByLetter(letter: arrayLetters()[section]).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalTableCell,
                                                       for: indexPath) as? UniversalTableCell else { return UITableViewCell() }
        let arrayByLetterItems = arrayByLetter(letter: arrayLetters()[indexPath.section])
        cell.configure(user: arrayByLetterItems[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    //MARK: - prepare cell in UsersPhotoViewController

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToPhotoController,
           let dst = segue.destination as? UsersPhotoViewController,
           let user = sender as? User {
            animatedChoose()
            dst.userID = user.id
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
