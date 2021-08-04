//
//  UserViewController.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 03/08/2021.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var token: UILabel!
    @IBOutlet weak var userId: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //guard let token = Session.instance.token
        let session = Session.instance
        token.text = session.token
        userId.text = String(describing: session.userId)
    }
    

}
