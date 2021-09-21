//
//  FriendsViewController.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 24/06/2021.
//

import UIKit
import RealmSwift

class FriendsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    lazy var realm = try! Realm()

    let reuseIdentifierUniversalTableCell =  "reuseIdentifierUniversalTableCell"
    let segueToPhotoController = "fromFriendsToPhoto"
    
    var friendsArray = [User]()
    var photoArray = [UserPhoto]()

    var searchFriendsArray = [User]()
    var searchFlag = false

    var databaseNotificationToken: NotificationToken?
    var resultNotificationToken: NotificationToken?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    //MARK:- viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "UniversalTableCell", bundle: nil),
                                forCellReuseIdentifier: reuseIdentifierUniversalTableCell)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        setupUser()
        print(realm.configuration.fileURL ?? "")

        self.tableView.reloadData()
    }


    //MARK:- setupUser
    
    func setupUser(){
        let network = NetworkService()
        network.friendsRequst { _ in}
        databaseNotificationToken = realm.observe { notification, realm in
            print(notification.rawValue)
            print(realm.objects(User.self))
        }
        let users = realm.objects(User.self)
        self.friendsArray = Array(users)

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

//MARK:- extension FriendsViewController

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayLetters().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayByLetter(letter: arrayLetters()[section]).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalTableCell, for: indexPath) as? UniversalTableCell else { return UITableViewCell() }
        let arrayByLetterItems = arrayByLetter(letter: arrayLetters()[indexPath.section])
        cell.configure(user: arrayByLetterItems[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    //MARK:- prepare cell in photoController

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToPhotoController,
           let dst = segue.destination as? PhotoController,
           let user = sender as? User {
            animatedChoose()

            // func getUserPhotos(){
            let network = NetworkService()
            let userID = user.id
            network.friendsPhotoRequst(userID: userID) { _ in}

            databaseNotificationToken = realm.observe { notification, realm in
                print(notification.rawValue)
                print(realm.objects(UserPhoto.self))
            }

            let userPhoto = realm.objects(UserPhoto.self)
            dst.photoArray = Array(userPhoto.filter { $0.owner_id == userID})

            resultNotificationToken = userPhoto.observe { change in
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
