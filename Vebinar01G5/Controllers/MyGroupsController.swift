//
//  MyGroupsController.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 01/07/2021.
//

import UIKit

class MyGroupsController: UITableViewController {

    var myGroups = [Group]()
    
    
    let reuseIdentifierUniversalTableCell =  "reuseIdentifierUniversalTableCell"
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "UniversalTableCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalTableCell)
        NotificationCenter.default.addObserver(self, selector: #selector(addNewGroup(_:)), name: NSNotification.Name(rawValue: "sendGroup"), object: nil)
    }
    
    func isContainInArray(group: Group) -> Bool {
        if myGroups.contains(where: { itemGroup in itemGroup.name == group.name}) {
            return true
        }
        return false
    }
    
    @objc func addNewGroup(_ notification: Notification){
        
        
        guard let newGroup = notification.object as? Group else {return}
        
        if isContainInArray(group: newGroup) {
            return
        }
        myGroups.append(newGroup)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        myGroups.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .middle)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalTableCell, for: indexPath) as? UniversalTableCell else { return UITableViewCell()}
        
        cell.configure(group: myGroups[indexPath.row])

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
