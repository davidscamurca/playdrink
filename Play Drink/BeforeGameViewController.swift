//
//  BeforeGameViewController.swift
//  Play Drink
//
//  Created by Anderson Oliveira on 13/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import UIKit

class BeforeGameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet var allCardsTV: UICollectionView!
    @IBOutlet var selectedCardsTV: UICollectionView!
    @IBOutlet var buttonTop: UIBarButtonItem!
    var allCards = CardStore.singleton.getCard()
    var selectedCards : [Card]? = []
    
    
    let collectionViewAIdentifier = "cellA"
    let collectionViewBIdentifier = "cellB"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allCardsTV.delegate = self
        self.allCardsTV.dataSource = self
        
        self.selectedCardsTV.dataSource = self
        self.selectedCardsTV.delegate = self
    }
    
    //Mark: Collection View Data Source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.allCardsTV {
            if !self.allCards.isEmpty {
                return self.allCards.count // Replace with count of your data for collectionViewA
            }
            return 0
        }
        
        if !(self.selectedCards?.isEmpty)! {
            return self.selectedCards!.count // Replace with count of your data for collectionViewB
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == self.allCardsTV {
            let cellA = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CardsCollectionViewCell
            
            cellA.title.text = self.allCards[indexPath.row].title
            return cellA
        }
            
        else {
            let cellB = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CardsCollectionViewCell
            
            cellB.title.text = self.selectedCards![indexPath.row].title
            
            return cellB
        }
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if collectionView == self.allCardsTV {
            
            let card = self.allCards[indexPath.item]
            self.selectedCards?.insert(card, atIndex: 0)
            self.selectedCardsTV.reloadData()

            
            self.allCards.removeAtIndex(indexPath.item)
            self.allCardsTV.deleteItemsAtIndexPaths([indexPath])
            self.allCardsTV.reloadData()
            
            if self.allCards.isEmpty {
                
                self.buttonTop.title = "Remove All"
            }
            
        }else {
            
            let card = self.selectedCards![indexPath.item]
            self.allCards.insert(card, atIndex: 0)
            self.allCardsTV.reloadData()
            
            
            self.selectedCards?.removeAtIndex(indexPath.item)
            self.selectedCardsTV.deleteItemsAtIndexPaths([indexPath])
            self.selectedCardsTV.reloadData()
            
            self.buttonTop.title = "Select All"
        }
    }
    
    //Mark: IBActions
    
    
    @IBAction func playGame(sender: UIButton) {
        if self.selectedCards?.count > 5 {
            performSegueWithIdentifier("playGame", sender: nil)
        }
    }
    
    @IBAction func selectOrDeselect(sender: UIBarButtonItem) {
        
        if sender.title == "Select All" {
            
            while !self.allCards.isEmpty {
                var i = 0
                let card = self.allCards[i]
                self.selectedCards?.insert(card, atIndex: 0)
                self.allCards.removeAtIndex(i)
                i += 1
                self.selectedCardsTV.reloadData()
                self.allCardsTV.reloadData()
            }
            sender.title = "Remove All"
        }else {
            
            while !(self.selectedCards?.isEmpty)! {
                var i = 0
                let card = self.selectedCards![i]
                self.allCards.insert(card, atIndex: 0)
                self.selectedCards!.removeAtIndex(i)
                i += 1
                self.selectedCardsTV.reloadData()
                self.allCardsTV.reloadData()
            }
            sender.title = "Select All"
        }
    }
    
    
}
