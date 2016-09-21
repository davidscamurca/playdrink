//
//  MyGamesViewController.swift
//  Play Drink
//
//  Created by Edson  Jr on 19/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import UIKit


class MyGamesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
   
    
    @IBOutlet weak var MyGamesCV: UICollectionView!
    
    @IBOutlet weak var StoreGamesCV: UICollectionView!
    
    //variables of array of games
    var allGames = GameStore.singleton.getGames()
    var myGames: Array<Game>?
    var storeGames: [Game]? = []
    
    
    override func viewDidLoad() {
        self.MyGamesCV.delegate = self
        self.MyGamesCV.dataSource = self
        
        self.StoreGamesCV.dataSource = self
        self.StoreGamesCV.delegate = self
        
        
        print(allGames.count)
        myGames = Array(arrayLiteral: allGames[0])
        print("My Games: \(myGames?.count)")
        
        
       
    }
    
    
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.MyGamesCV{
            if !self.myGames!.isEmpty{
                return self.myGames!.count
            }
            return 0
        }
        
        if !(self.storeGames?.isEmpty)! {
            print(self.storeGames?.count)
            return self.storeGames!.count
        }
        return 0
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == self.MyGamesCV {
            let myGamesCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MyCollectionViewCell
            
            myGamesCell.cellImage.image = self.myGames![indexPath.row].gameIcon
            myGamesCell.cellLabel.text = self.myGames![indexPath.row].gameName
            return myGamesCell
        }else {
            let storeGamesCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as!
                MyCollectionViewCell
            
            storeGamesCell.cellImage.image = storeGames![indexPath.row].gameIcon
            storeGamesCell.cellLabel.text = storeGames![indexPath.row].gameName
            
            return storeGamesCell
        }
    
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
            
    }
    
    
}




