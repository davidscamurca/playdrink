//
//  MyGamesViewController.swift
//  Play Drink
//
//  Created by Edson  Jr on 19/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import UIKit


class MyGamesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Mark: IBOutlet
    
    @IBOutlet weak var MyGamesCV: UICollectionView!
    @IBOutlet weak var StoreGamesCV: UICollectionView!
    
    //variables of array of games
    var allGames = GameStore.singleton.getGames()
    var myGames: Array<Game>?
    var store: Array<Game>?
    
    //support vars
    var c = 1
    
    
    //alerts
    var alertView: UIAlertView?
    var alertController: UIAlertController?
    
    
    //background image
    var viewBackground = UIImageView(image: UIImage(named: "background"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(viewBackground)
        self.view.sendSubviewToBack(viewBackground)
        
        
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
        print("All store games: \(store?.count)")
       
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
        
        
        if collectionView == self.StoreGamesCV {
            print("selected: \(indexPath.row) -- total store: \(store?.endIndex)")
            if indexPath.row == (store?.endIndex)!-1{
                print("go to shop")
            }else {
                
                //alert to buy a game
                self.alertController = UIAlertController(title: "Buy Game", message: "Do you wish buy this game?", preferredStyle: .Alert)
                
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
                    
                }
                
                //button to cancel operation
                let cancelButton = UIAlertAction(title: "Cancel", style: .Default){
                    UIAlertAction in
                    self.alertController?.dismissViewControllerAnimated(true, completion: nil)
                }
                
                //add buttons in alertController
                self.alertController?.addAction(buyButton)
                self.alertController?.addAction(cancelButton)
                
                
                self.presentViewController(alertController!, animated: true, completion: nil)
               
                
            }
            
            
        }
            
    }
    
    
}




