//
//  MyFriendsControllerView.swift
//  Play Drink
//
//  Created by Edson  Jr on 20/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import UIKit

class MyFriendsControllerView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    //Mark: IBOutlets
    
    @IBOutlet weak var selectedCollectionView: UICollectionView! //top collection
    @IBOutlet weak var toPlayCollectionView: UICollectionView! //botton collection
    
    
    //var to players
    var allPlayers = PlayerStore.singleton.getPlayers()
    var allPlayersReverse : [Player]!
    
    var selecteds : [Player]? = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allPlayersReverse = self.allPlayers.reversed()
        
        for _ in 0...3 {
            let player = self.allPlayersReverse[self.allPlayersReverse.count-2]
            self.selecteds?.insert(player, at: 0)
            self.allPlayersReverse.remove(at: self.allPlayersReverse.count-2)
        }
        
        self.selectedCollectionView.delegate = self
        self.selectedCollectionView.dataSource = self
        
        self.toPlayCollectionView.delegate = self
        self.toPlayCollectionView.dataSource = self
    }
    
    //Mark: Collectionview Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.toPlayCollectionView {
            if !self.allPlayersReverse.isEmpty {
                return self.allPlayersReverse.count // Replace with count of your data for collectionViewA
            }
            return 0
        }
        
        if !(self.selecteds?.isEmpty)! {
            return self.selecteds!.count // Replace with count of your data for collectionViewB
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.toPlayCollectionView{
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
            
            cellA.cellLabel.text = self.allPlayersReverse[indexPath.row].name
            cellA.cellLabel2.text = self.allPlayersReverse[indexPath.row].description
            cellA.cellImage.image = self.allPlayersReverse[indexPath.row].avatar
            return cellA
        }
        
        else {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
            
            cellB.cellLabel.text = self.selecteds![indexPath.row].name
            cellB.cellLabel2.text = self.selecteds![indexPath.row].description
            cellB.cellImage.image = self.selecteds![indexPath.row].avatar
            return cellB
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.toPlayCollectionView {
            
            let player = self.allPlayersReverse[indexPath.item]
            self.selecteds?.insert(player, at: 0)
            self.selectedCollectionView.reloadData()
            
            self.allPlayersReverse.remove(at: indexPath.item)
            self.toPlayCollectionView.deleteItems(at: [indexPath])
            self.toPlayCollectionView.reloadData()
            
        }else{
            
            let player = self.selecteds![indexPath.item]
            self.allPlayersReverse.insert(player, at: 0)
            self.toPlayCollectionView.reloadData()
            
            self.selecteds?.remove(at: indexPath.item)
            self.selectedCollectionView.deleteItems(at: [indexPath])
            self.selectedCollectionView.reloadData()
        }
        
        
    }
    
    
    //Mark: IBActions
    
    @IBAction func backButton(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)

    }
    
    //Mark: Status Bar Delegate
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    
    

}

