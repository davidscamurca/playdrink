//
//  PreGameSuecaViewController.swift
//  Play Drink
//
//  Created by Edson  Jr on 23/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import UIKit


class PreGameSuecaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    var all = PlayerStore.singleton.getPlayers()
    
    var allPlayers : [Player]! = []
    
    //Mark: IBActions
    @IBAction func backButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0...4 {
            let player = self.all[0]
            self.allPlayers.append(player)
            self.all.removeAtIndex(0)
        }
    }
    
    //Mark: Collection View Data Source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !self.allPlayers.isEmpty {
            return self.allPlayers.count // Replace with count of your data for collectionViewA
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MyCollectionViewCell
        
        cell.cellLabel.text = self.allPlayers[indexPath.row].name
        cell.cellLabel2.text = self.allPlayers[indexPath.row].description
        cell.cellImage.image = self.allPlayers[indexPath.row].avatar
        
        return cell
    }
    
    //Mark: Status Bar Delegate
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}