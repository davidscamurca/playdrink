//
//  MyFriendsControllerView.swift
//  Play Drink
//
//  Created by Edson  Jr on 20/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import UIKit

class MyFriendsControllerView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    
    @IBOutlet weak var selectedCollectionView: UICollectionView! //top collection
    @IBOutlet weak var toPlayCollectionView: UICollectionView! //botton collection
    
    
    //var to players
    var allPlayers = PlayerStore.singleton.getPlayers()
    var selecteds : [Player]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedCollectionView.delegate = self
        self.selectedCollectionView.dataSource = self
        
        self.toPlayCollectionView.delegate = self
        self.toPlayCollectionView.dataSource = self
        
        print(self.allPlayers.count)
        print(self.allPlayers[0].name)

    }
    
    
    
    
    
    //Mark: Collectionview Data Source
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.toPlayCollectionView {
            if !self.allPlayers.isEmpty {
                return self.allPlayers.count // Replace with count of your data for collectionViewA
            }
            return 0
        }
        
        if !(self.selecteds?.isEmpty)! {
            return self.selecteds!.count // Replace with count of your data for collectionViewB
        }
        return 0
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == self.toPlayCollectionView{
            let cellA = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MyCollectionViewCell
            
            cellA.cellLabel.text = self.allPlayers[indexPath.row].name
            cellA.cellImage.image = self.allPlayers[indexPath.row].avatar
            return cellA
        }
        
        else {
            let cellB = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MyCollectionViewCell
            
            cellB.cellLabel.text = self.selecteds![indexPath.row].name
            cellB.cellImage.image = self.selecteds![indexPath.row].avatar
            
            return cellB
        }
        
        
        let cellC = collectionView.dequeueReusableCellWithReuseIdentifier("storeCell", forIndexPath: indexPath) as! MyCollectionViewCell
        
        cellC.cellLabel.text = "Buy"
        cellC.cellImage.image = UIImage(named: "coin")
        return cellC
    }
    
    
      func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
       
       
        
        
        if collectionView == self.toPlayCollectionView {
            let player = self.allPlayers[indexPath.item]
            self.selecteds?.insert(player, atIndex: 0)
            self.selectedCollectionView.reloadData()
            
            self.allPlayers.removeAtIndex(indexPath.item)
            self.toPlayCollectionView.deleteItemsAtIndexPaths([indexPath])
            self.toPlayCollectionView.reloadData()
        }else{
            print("selectedCollectionView clicked!")
            let player = self.selecteds![indexPath.item]
            self.allPlayers.insert(player, atIndex: 0)
            self.toPlayCollectionView.reloadData()
            
            self.selecteds?.removeAtIndex(indexPath.item)
            self.selectedCollectionView.deleteItemsAtIndexPaths([indexPath])
            self.selectedCollectionView.reloadData()
        }
        
        
    }

}

