//
//  NewsController.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 08/07/2021.
//

import UIKit
import RealmSwift
import SwiftyJSON

class NewsController: UIViewController {

    let reuseIdentifierUniversalTableCell =  "reuseIdentifierUniversalTableCell"

    @IBOutlet weak var newsTableView: UITableView! {
        didSet {
            newsTableView.dataSource = self
            newsTableView.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsTableView.register(UINib(nibName: "UniversalTableCell", bundle: nil),
                                    forCellReuseIdentifier: reuseIdentifierUniversalTableCell)
       // newsRequest()
    }

}

extension NewsController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("\(indexPath.row) row selected")
    }
}

extension NewsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalTableCell,
                                                           for: indexPath) as? UniversalTableCell else { return UITableViewCell() }
        cell.avatarImageView.image = UIImage(named: "bulbasaur")
        cell.titleLabel.text = "новость"
        return cell
    }


}
