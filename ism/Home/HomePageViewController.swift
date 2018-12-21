//
//  HomePageViewController.swift
//  ism
//
//  Created by DAS on 10/26/18.
//  Copyright © 2018 sunrise. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!

    let titles = ["1", "2", "3","4"]
    
    let images: [UIImage] = [
    UIImage(named: "homeBar")!,
    UIImage(named: "homeBar")!,
    UIImage(named: "homeBar")!,
    UIImage(named: "homeBar")!,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(titles.count)
        return titles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellHome = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)as! CollectionViewCell
        
        cellHome.label.text = titles[indexPath.item]
//        cellHome.imageView.image = images[indexPath.item]
        print("ITEM (asd)")
        return cellHome
    }

}
