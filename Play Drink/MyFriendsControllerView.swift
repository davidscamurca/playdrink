//
//  MyFriendsControllerView.swift
//  Play Drink
//
//  Created by Edson  Jr on 20/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import UIKit

class MyFriendsControllerView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var selectedsCollectionView: UICollectionView!
    @IBOutlet weak var toPlayCollectionView: UICollectionView!
    
    
    
    //var to players
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    
    
    //Mark: Collectionview Data Source
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

    }
    
    
      func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
