//
//  MyGamesViewController.swift
//  Play Drink
//
//  Created by Edson  Jr on 19/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import UIKit


class MyGamesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
   
    @IBOutlet weak var coinsAvaliableLabel: UILabel!
    
    
    @IBOutlet weak var MyGamesCV: UICollectionView!
    @IBOutlet weak var StoreGamesCV: UICollectionView!
    
    //variables of array of games
    var allGames = GameStore.singleton.getGames()
    var myGames: Array<Game>?
    var store: Array<Game>?
    
    //support vars
    var c = 1
    var coinsAvaliable: Int = Int(375)
    
    
    //alerts
    var alertView: UIAlertView?
    var alertController: UIAlertController?
    
    
    override func viewWillAppear(animated: Bool) {
         self.coinsAvaliableLabel.text = String(self.coinsAvaliable)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.MyGamesCV.delegate = self
        self.MyGamesCV.dataSource = self
        
        self.StoreGamesCV.dataSource = self
        self.StoreGamesCV.delegate = self
        
        
        print("All games: \(allGames.count)")
        myGames = Array(arrayLiteral: allGames[0])
        print("My Games: \(myGames?.count)")
        
        store = Array()
        while c < allGames.count {
            store?.append(allGames[c])
            c = c+1
        }
        print(store?.count)
       
    }
    
    
    //Mark: UICollectionView
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.MyGamesCV{
            if !self.myGames!.isEmpty{
                return self.myGames!.count
            }
            return 0
        }
        else if collectionView == self.StoreGamesCV {
            return  (store?.count)!
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
            
            storeGamesCell.cellImage.image = store![indexPath.row].gameIcon
            storeGamesCell.cellLabel.text = store![indexPath.row].gameName
            
            return storeGamesCell
        }
    
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var itemNo = indexPath.row
        
        
        if collectionView == self.StoreGamesCV {
            if itemNo == 2{
                print("go to shop")
            }else {
                
                //alert to buy a game
                self.alertController = UIAlertController(title: "Buy Game", message: "Do you wish buy this game for 10 coins?", preferredStyle: .Alert)
                
                //creating buttons to alert
                let buyButton = UIAlertAction(title: "Buy", style: .Default){
                    UIAlertAction in
                    print("Game sold!")
                    let game = self.store![indexPath.item]
                    self.myGames?.insert(game, atIndex: 1)
                    self.MyGamesCV.reloadData()
                    
                    self.store?.removeAtIndex(indexPath.row)
                    self.StoreGamesCV.deleteItemsAtIndexPaths([indexPath])
                    self.StoreGamesCV.reloadData()
                    
                    self.coinsAvaliable = self.coinsAvaliable-10
                    self.coinsAvaliableLabel.text = String(self.coinsAvaliable)
                    
                }
                
                let cancelButton = UIAlertAction(title: "Cancel", style: .Default){
                    UIAlertAction in
                    self.alertController?.dismissViewControllerAnimated(true, completion: nil)
                }
                
                self.alertController?.addAction(buyButton)
                self.alertController?.addAction(cancelButton)
                
                
                self.presentViewController(alertController!, animated: true, completion: nil)
               
                
            }
            
            
        }
            
    }
    
    
}




