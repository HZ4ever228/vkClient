//
//  PhotoController.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 28/06/2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotoController: UICollectionViewController {
    
    var photoArray: [UserPhoto] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCell else {return UICollectionViewCell()}

        let aaa = photoArray[indexPath.row]
       // print(aaa)
        cell.configure(userPhoto: aaa)
        return cell

    }
}

