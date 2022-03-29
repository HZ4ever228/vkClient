//
//  UsersPhotoViewController.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 03/01/2022.
//

import UIKit
import RealmSwift

class UsersPhotoViewController: UIViewController {
    
    public var userID: Int?

    @IBOutlet weak var usersPhotoTableView: UITableView! {
        didSet {
            usersPhotoTableView.delegate = self
            usersPhotoTableView.dataSource = self
        }
    }
    
    private var realm = try! Realm()
    private var photoArray: [String] = []
    
    //MARK: - LifeCicle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let userID = userID, userID != nil {
            getUsersPhotos(userID: userID)
        } else {
            debugPrint("userid is empty")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - ACTIONS -
    
    private func getUsersPhotos(userID: Int) {
        DataRepository.shared.getFriendsPhotos(userID: userID, completion: { error, userPhotos in
            if error == nil, let userPhotos = userPhotos {
                for photo in userPhotos.userPhotos {
                    self.photoArray.append(photo)
                }
                self.usersPhotoTableView.reloadData()
            } else {
                debugPrint(error)
            }
        })
    }

}

//MARK: - Extensions: UITableViewDelegate, UITableViewDataSource -

extension UsersPhotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = usersPhotoTableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.reuseIdentifier, for: indexPath) as? PhotoTableViewCell {
            
            let stringForCell = photoArray[indexPath.row]
            debugPrint("stringForCell: \(stringForCell)")
            cell.configure(photoSting: stringForCell)
            
            return cell
        } else {
            debugPrint("stringForCell is not found")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("\(indexPath.row) is cellected")
    }
    
    
}
