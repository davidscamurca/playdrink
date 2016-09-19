//
//  MyGamesViewController.swift
//  Play Drink
//
//  Created by Edson  Jr on 19/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import UIKit


class MyGamesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
   
    
    @IBOutlet weak var MyGamesCollection: UICollectionView! //collectionView of games that you can play
    let reuserIdentifier  = "cell"
    
    
    override func viewDidLoad() {
        
    }
    
    
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = MyGamesCollection.dequeueReusableCellWithReuseIdentifier(reuserIdentifier, forIndexPath: indexPath) as! MyCollectionViewCell
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    
    }
    
    
}




