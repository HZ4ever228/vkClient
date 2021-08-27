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
    var allGroups = [Group]()
    var searchAllGroups = [Group]()
    var searchFlag = false
    lazy var realm = try! Realm()

    let reuseIdentifierUniversalTableCell =  "reuseIdentifierUniversalTableCell"


    //MARK:- setupGroup

        func setupGroup(){
                let network = NetworkService()
                network.groupsRequest { _ in}
                let groups = realm.objects(Group.self)
                self.allGroups = Array(groups)
        }


    //MARK:- viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "UniversalTableCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalTableCell)
        searchBar.delegate = self
        setupGroup()
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
