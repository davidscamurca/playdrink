//
//  BeforeGameViewController.swift
//  Play Drink
//
//  Created by Anderson Oliveira on 13/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class BeforeGameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var allCards = CardStore.singleton.getCard()
    var selectedCards : [Card]? = []
    var numCards = 6
    let collectionViewAIdentifier = "cellA"
    let collectionViewBIdentifier = "cellB"
    
    //Mark: IBOutlets
    
    @IBOutlet var allCardsTV: UICollectionView!
    @IBOutlet var selectedCardsTV: UICollectionView!
    @IBOutlet var buttonTop: UIBarButtonItem!
    @IBOutlet var numCardsLabel: UILabel!
    
    //Mark: IBActions
    
    @IBAction func playGame(_ sender: UIButton) {
        print(self.selectedCards?.count)
        if self.selectedCards?.count > 5 {
            performSegue(withIdentifier: "playGame", sender: nil)
        }else {
            self.numCardsLabel.frame.origin.x = 30
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
                self.numCardsLabel.frame.origin.x = 0
                }, completion: nil)
        }
    }
    
    @IBAction func selectOrDeselect(_ sender: UIBarButtonItem) {
        
        if sender.title == "Select All" {
            
            while !self.allCards.isEmpty {
                var i = 0
                let card = self.allCards[i]
                self.selectedCards?.insert(card, at: 0)
                self.allCards.remove(at: i)
                i += 1
                self.selectedCardsTV.reloadData()
                self.allCardsTV.reloadData()
            }
            self.numCards = 0
            self.numCardsLabel.text = "Add at least \(self.numCards) cards in order to play"
            sender.title = "Remove All"
        }else {
            
            while !(self.selectedCards?.isEmpty)! {
                var i = 0
                let card = self.selectedCards![i]
                self.allCards.insert(card, at: 0)
                self.selectedCards!.remove(at: i)
                i += 1
                self.selectedCardsTV.reloadData()
                self.allCardsTV.reloadData()
            }
            self.numCards = 6
            self.numCardsLabel.text = "Add at least \(self.numCards) cards in order to play"
            sender.title = "Select All"
        }
    }
    
    @IBAction func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allCardsTV.delegate = self
        self.allCardsTV.dataSource = self
        
        self.selectedCardsTV.dataSource = self
        self.selectedCardsTV.delegate = self
    }
    
    //Mark: Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.allCardsTV {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardsCollectionViewCell
            
            cellA.imageView.image = self.allCards[indexPath.row].mImage
            return cellA
        }
            
        else {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardsCollectionViewCell
            
            cellB.imageView.image = self.selectedCards![indexPath.row].pImage
            return cellB
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.allCardsTV {
            
            let card = self.allCards[indexPath.item]
            self.selectedCards?.insert(card, at: 0)
            self.selectedCardsTV.reloadData()
            
            
            self.allCards.remove(at: indexPath.item)
            self.allCardsTV.deleteItems(at: [indexPath])
            self.allCardsTV.reloadData()
            
            if self.numCards > 0{
                self.numCards -= 1
                self.numCardsLabel.text = "Add at least \(self.numCards) cards in order to play"
            }
            
            if self.allCards.isEmpty {
                
                self.buttonTop.title = "Remove All"
            }
            
        }else {
            
            let card = self.selectedCards![indexPath.item]
            self.allCards.insert(card, at: 0)
            self.allCardsTV.reloadData()
            
            
            self.selectedCards?.remove(at: indexPath.item)
            self.selectedCardsTV.deleteItems(at: [indexPath])
            self.selectedCardsTV.reloadData()
            
            if self.selectedCards?.count < 6{
                self.numCards = (6 - self.selectedCards!.count)
                self.numCardsLabel.text = "Add at least \(self.numCards) cards in order to play"
            }
            
            self.buttonTop.title = "Select All"
        }
    }
    
    //Mark: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "playGame" {
            
            let nextVC = segue.destination as! GameViewController
            var fourTimesSelectedCards : [Card]! = []
            var i = 0
            
            
            while fourTimesSelectedCards.count != 11 {
                
                let card = i % selectedCards!.count
                i += 1
                fourTimesSelectedCards.append(self.selectedCards![card])
            }
            nextVC.cardModel = fourTimesSelectedCards
        }
    }
    
    //Mark: Status Bar Delegate
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}
