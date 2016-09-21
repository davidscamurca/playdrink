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
    @IBOutlet var numCardsLabel: UILabel!
    var allCards = CardStore.singleton.getCard()
    var selectedCards : [Card]? = []
    var numCards = 6
    
    
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
            
            if self.numCards > 0{
                self.numCards -= 1
                self.numCardsLabel.text = "add at least \(self.numCards) cards in order to play"
            }
            
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
            
            if self.selectedCards?.count < 6{
                self.numCards = (6 - self.selectedCards!.count)
                self.numCardsLabel.text = "add at least \(self.numCards) cards in order to play"
            }
            
            self.buttonTop.title = "Select All"
        }
    }
    
    //Mark: IBActions
    
    @IBAction func playGame(sender: UIButton) {
        if self.selectedCards?.count > 5 {
            performSegueWithIdentifier("playGame", sender: nil)
        }else {
            self.numCardsLabel.frame.origin.x = 30
            UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .CurveEaseOut, animations: {
                self.numCardsLabel.frame.origin.x = 0
                }, completion: nil)
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
            self.numCards = 0
            self.numCardsLabel.text = "add at least \(self.numCards) cards in order to play"
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
            self.numCards = 6
            self.numCardsLabel.text = "add at least \(self.numCards) cards in order to play"
            sender.title = "Select All"
        }
    }
    
    //Mark: Func's
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "playGame" {
            
            let nextVC = segue.destinationViewController as! GameViewController
            var fourTimesSelectedCards : [Card]! = []
            var i = 0
            
            
            while fourTimesSelectedCards.count != 12 {
                
                let card = i % selectedCards!.count
                i += 1
                fourTimesSelectedCards.append(self.selectedCards![card])
            }
            nextVC.cardModel = fourTimesSelectedCards
        }
    }
    
}
