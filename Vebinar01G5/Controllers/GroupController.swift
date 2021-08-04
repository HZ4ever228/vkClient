//
//  GroupController.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 01/07/2021.
//

import UIKit

class GroupController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var allGroups = [Group]()
    var searchAllGroups = [Group]()
    var searchFlag = false
    
    let reuseIdentifierUniversalTableCell =  "reuseIdentifierUniversalTableCell"
    
    func setupGroup() -> [Group] {
        var resultArray = [Group]()
        
        let firstGroup = Group(title: "Pokemons", avatar: UIImage(named: "pok1")!, description: "Pokemons Group")
        resultArray.append(firstGroup)
        
        let secondGroup = Group(title: "Orcs", avatar: UIImage(named: "ork1")!, description: "Orcs Group")
        resultArray.append(secondGroup)
        
        let thirdGroup = Group(title: "Groots", avatar: UIImage(named: "groot4")!, description: "Groots Group")
        resultArray.append(thirdGroup)
        
        return resultArray
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allGroups = setupGroup()
        self.tableView.register(UINib(nibName: "UniversalTableCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalTableCell)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return arrayLetters().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayByLetter(letter: arrayLetters()[section]).count
        
        //return allGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalTableCell, for: indexPath) as? UniversalTableCell else { return UITableViewCell()}
        
        let arrayByLetterItems = arrayByLetter(letter: arrayLetters()[indexPath.section])
        //cell.configure(group: allGroups[indexPath.row])
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searchFlag = false
        }
        else {
            searchFlag = true
            searchAllGroups = allGroups.filter({
                item in item.title.lowercased().contains(searchText.lowercased())
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
            let nameLetter = String(item.title.prefix(1))
            if !resultArray.contains(nameLetter) {
                resultArray.append(nameLetter)
            }
        }
        return resultArray
    }
    
    func arrayByLetter(letter: String) -> [Group] {
        var resultArray = [Group]()
        for item in myFriendsArray() {
            let nameLetter = String(item.title.prefix(1))
            if nameLetter == letter {
                resultArray.append(item)
            }
        }
        return resultArray
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayLetters()[section].uppercased()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
