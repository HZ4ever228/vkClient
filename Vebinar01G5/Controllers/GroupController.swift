//
//  GroupController.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 01/07/2021.
//

import UIKit
import RealmSwift

class GroupController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    private let reuseIdentifierUniversalTableCell =  "reuseIdentifierUniversalTableCell"
    
    private var allGroups = [Group]()
    private var searchAllGroups = [Group]()
    private var searchFlag = false
    private var realm = try! Realm()
    private var databaseNotificationToken: NotificationToken?
    private var resultNotificationToken: NotificationToken?

    //MARK: - LifeCicle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "UniversalTableCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalTableCell)
        searchBar.delegate = self
        setupGroup()
    }

    //MARK: - actions

    func setupGroup(){
        DataRepository.shared.getGroups(completion: { error, groups in
            if error == nil, let groupsArray = groups {
                self.allGroups = groupsArray
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    func notificationsObserve(groups: Results<Group>) {
        
        databaseNotificationToken = realm.observe { notification, realm in
            print(notification.rawValue)
            print(realm.objects(Group.self))
        }
        
        resultNotificationToken = groups.observe { change in
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return arrayLetters().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayByLetter(letter: arrayLetters()[section]).count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalTableCell, for: indexPath) as? UniversalTableCell else { return UITableViewCell()}
        
        let arrayByLetterItems = arrayByLetter(letter: arrayLetters()[indexPath.section])
        cell.configure(group: arrayByLetterItems[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UniversalTableCell,
              let cellObject = cell.savedObject as? Group else {return }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sendGroup"), object: cellObject)
        self.navigationController?.popViewController(animated: true)
    }

//MARK: -searchBar

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searchFlag = false
        }
        else {
            searchFlag = true
            searchAllGroups = allGroups.filter({
                item in item.name.lowercased().contains(searchText.lowercased())
            })
        }
        tableView.reloadData()
    }
    
    func myFriendsArray() -> [Group] {
        if searchFlag {
            return searchAllGroups
        }
        return allGroups
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
    
    func arrayByLetter(letter: String) -> [Group] {
        var resultArray = [Group]()
        for item in myFriendsArray() {
            let nameLetter = String(item.name.prefix(1))
            if nameLetter == letter {
                resultArray.append(item)
            }
        }
        return resultArray
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayLetters()[section].uppercased()
    }
    

}
