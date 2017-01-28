//
//  GameViewController.swift
//  Play Drink
//
//  Created by Anderson Oliveira on 13/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//
//Este código é relativamente básico e provavelmente será reconstruido por causa da animacao [Edson Jr - 15/09/2016]
//

import UIKit

enum cardModification {
    case needToAlter
    case needToUnalter
    case finished
}

class GameViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var viewsAndRotations = [CardView : CGFloat]() // can remove cards from this
    var cardViews = [CardView]() // don't remove cards from this.
    var cardInfos = [Card]() // don't remove the card data from this
    var cardModel : [Card]? = []
    var animator : UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior?
    var snapBehavior : UISnapBehavior!
    var cardFrame : CGRect!
    var cardIsDropping  = false
    let cardCornerRadius = CGFloat(20)
    var didReturnFromTransition = false
    let mainQueue = DispatchQueue.main
    let progressIndicator = UIProgressView(progressViewStyle: UIProgressViewStyle.bar)
    var topCardImage : UIImageView!
    var increment : Float!
    
    //Mark: IBOutlets
    
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet var undoButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    //Mark: IBActions
    
    @IBAction func panDetected(_ sender: AnyObject) {
        if self.view.subviews.count < 5 || (self.view.subviews.last! is CardView == false) { // will change if more views are added to self.view
            return
        }
        let card = self.view.subviews.last! as! CardView
        let location = sender.location(in: view)
        let boxLocation = sender.location(in: card)
        if sender.state == UIGestureRecognizerState.began {
            if let b = attachmentBehavior {
                animator.removeBehavior(b)
            }
            let centerOffset = UIOffsetMake(boxLocation.x - card.bounds.midX, boxLocation.y - card.bounds.midY)
            attachmentBehavior = UIAttachmentBehavior(item: card, offsetFromCenter: centerOffset, attachedToAnchor: location)
            animator.addBehavior(attachmentBehavior!)
        } else if sender.state == UIGestureRecognizerState.changed {
            attachmentBehavior!.anchorPoint = location
        } else if sender.state == UIGestureRecognizerState.ended {
            animator.removeBehavior(attachmentBehavior!)
            snapBehavior = UISnapBehavior(item: card, snapTo: view.center)
            animator.addBehavior(snapBehavior)
            
            let translation = sender.translation(in: view)
            if abs(translation.y) > 100 || abs(translation.x) > 100 {
                cardIsDropping = true //fixes issue of topCard on tap being the one that drops
                card.isUserInteractionEnabled = false
                animator.removeAllBehaviors()
                let gravity = UIGravityBehavior(items: [card])
                gravity.gravityDirection = CGVector(dx: translation.x/15, dy: translation.y/15) //pulled in the direction of the swipe
                animator.addBehavior(gravity)
                
                UIView.animateKeyframes(withDuration: 0.1, delay: 0.3, options: UIViewKeyframeAnimationOptions(), animations: { () -> Void in
                    card.alpha = 0
                    }, completion: { (fin) -> Void in
                        card.removeFromSuperview()
                        self.cardIsDropping = false
                        self.animator.removeAllBehaviors()
                        let newProgress = Float(1.0) / Float(self.cardViews.count) + self.progressIndicator.progress
                        self.progressIndicator.setProgress(newProgress, animated: true)
                        self.progressIndicator.tintColor = UIColor.white
//                        self.progressIndicator.backgroundColor = UIColor.whiteColor()
                        self.viewsAndRotations.removeValue(forKey: card)
                        
                        if self.viewsAndRotations.count == 0 { //no more cards to show, so present option to restart
                            self.reset(self)
                        }else {
                            let newTopCard = self.view.subviews.last! as UIView
                            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                                newTopCard.center = self.view.center
                                self.undoButton.alpha = 1
                            })
                            self.snapBehavior = UISnapBehavior(item: newTopCard, snapTo: self.view.center)
                            self.animator.addBehavior(self.snapBehavior)
                        }
                        
                })
            }
        }
    }
    
    @IBAction func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func reset(_ sender: AnyObject) {
        
        self.resetButton.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.2, animations: {
            self.resetButton.alpha = 0
        })
                
        for card in self.viewsAndRotations.keys {
            card.removeFromSuperview()
        }
        self.viewsAndRotations.removeAll(keepingCapacity: false)
        cardViews = cards()
        progressIndicator.setProgress(0.0, animated: true)
        dropCards(cardViews, animation: true) // can't use dictonary keys because they dont have order
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.undoButton.alpha = 0
        })
        
    }
    
    @IBAction func undo(_ sender: AnyObject) {
        let pos = viewsAndRotations.count
        if pos > cardViews.count-1 { //make sure index isn't out of range
            return
        }
        let card = cardViews[pos]
        viewsAndRotations[card] = CGFloat(0)
        card.frame = CGRect(x: 50, y: 150, width: self.view.frame.width - 100, height: self.view.frame.height - 300) //restoring these two properties b/c when card is expanded, they lose them
        card.layer.cornerRadius = cardCornerRadius
        UIView.animate(withDuration: 0.01, animations: { () -> Void in
            card.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
            card.alpha = 0.8
        })
        progressIndicator.setProgress(progressIndicator.progress - self.increment, animated: true)
        self.progressIndicator.tintColor = UIColor.white
        dropCards([card], animation: false)
        
        
        
        if self.viewsAndRotations.keys.count == self.cardViews.count { //at start of card deck
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.undoButton.alpha = 0
            })
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
        if (self.cardModel?.isEmpty)! {
            self.cardModel = CardStore.singleton.getCard()
        }
        self.cardFrame = CGRect(x: 50, y: 150, width: self.view.frame.width - 100, height: self.view.frame.height - 300)
        animator = UIDynamicAnimator(referenceView: view)
        progressIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: progressIndicator.frame.height + 20)
        view.insertSubview(progressIndicator, at: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if didReturnFromTransition == false {
            
            if self.view.subviews.count == 6 {
            
                self.resetButton.isUserInteractionEnabled = false
                cardViews = cards()
                increment = Float(1.0) / Float(cardViews.count)
                dropCards(cardViews, animation: true) // can't use dictonary keys because they dont have order
                
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    self.resetButton.alpha = 0
                    self.undoButton.alpha = 0
                })
            }
        } else { //just returned from the transition
            
            let topCard = view.subviews[view.subviews.count-2] as! CardView //since there is another uiimageview on top, get 2nd last subview
            
            // undo the detail view transition animations
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                topCard.frame = self.cardFrame
                self.topCardImage.frame = CGRect(x: 0, y: 0, width: self.cardFrame.width, height: self.cardFrame.width * (2.0/3.0))
                self.topCardImage.frame.origin = self.cardFrame.origin
                topCard.layer.cornerRadius = self.cardCornerRadius
                //self.topCardImage.layer.cornerRadius = self.cardCornerRadius
                topCard.layer.shadowOpacity = 1
                }, completion: { (fin) -> Void in
                    topCard.image.alpha = 1
                    self.topCardImage.removeFromSuperview() //remove image placed before animated transition
            })
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func NextVC() {
        self.performSegue(withIdentifier: "detailCard", sender: nil)
    }
    
    // MARK: - Card
    
    func dropCards(_ cards: [CardView], animation: Bool) {
        var cards = cards
        
        if let card = cards.first {
            if cards.count == 1 {
                self.viewsAndRotations[card] = CGFloat(0)
            }
            
            if animation {
                card.image.image = UIImage(named: "cardBack")
            }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(GameViewController.NextVC))
            card.addGestureRecognizer(tap)
            self.view.addSubview(card)
            
            //add autolayout
            cardConstraints(card)
            
            //	card.layoutIfNeeded()
            UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                
                card.alpha = 1
                card.transform = CGAffineTransform(rotationAngle: self.viewsAndRotations[card]!).concatenating(CGAffineTransform(scaleX: 1, y: 1))
                }, completion: { (finished) -> Void in
                    
                    let delay = 0
                    Thread.sleep(forTimeInterval: TimeInterval(delay))
                    cards.remove(at: 0)
                    self.dropCards(cards, animation: animation)
                    
                    if cards.count == 0 { // first step in guiding the user for the first time
                        
                        var i = 0
                        self.resetButton.isUserInteractionEnabled = true
                        UIView.animate(withDuration: 0, animations: {
                            if animation {
                                for cardf in self.view.subviews{
                                    if cardf is CardView{
                                        (cardf as! CardView).image.image = self.cardInfos[i].image
                                        i += 1
                                    }
                                }
                            }
                            self.resetButton.alpha = 1.0
                        })
                    }
            })
        }
        
    }
    
    func cards() -> [CardView] {
        var cardsArray = [CardView]()
        self.cardInfos = self.cardModel!.suffle()
        for i in 0 ..< self.cardInfos.count {
            let card = self.generateCard(self.cardInfos[i])
            cardsArray.append(card)
        }
        return cardsArray
    }
    
    func generateCard(_ cInfo : Card) -> CardView {
        let card = UINib(nibName: "View", bundle: nil).instantiate(withOwner: CardView(), options: nil).first! as! CardView
        card.setup(cInfo, cornerRad: cardCornerRadius, target: self)
        viewsAndRotations[card] = randomAngle()
        return card
    }
    
    func randomAngle() -> CGFloat {
        var angle : Float = Float(arc4random_uniform(10)) // in degress
        
        if arc4random() % 2 == 1 { //50% chance of negative angle.
            angle = -angle
        }
        //convert angle into radians
        angle *= (Float(M_PI) / Float(180))
        return CGFloat(angle)
    }
    
    func cardConstraints(_ card: CardView) {
        let Vconstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-offset-[card]-offset-|", options: NSLayoutFormatOptions(), metrics: ["offset": self.view.frame.height/7], views: ["card" : card])
        let Hconstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-offset-[card]-offset-|", options: NSLayoutFormatOptions(), metrics: ["offset": self.view.frame.width/10], views: ["card" : card])
        self.view.addConstraints(Vconstraints + Hconstraints)
    }
    
    //Mark: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailCard" {
            let nextVC = segue.destination as! DetailCardViewController
            let cInfo = cardInfos[self.view.subviews.count - 7]
            nextVC.titleTxt = cInfo.title
            nextVC.descriptionTxt = cInfo.descriptionn
            nextVC.image = cInfo.image
            print("w: \((self.view.subviews.last?.frame.height)! / self.view.frame.height)")
        }
    }
    
    //Mark: Status Bar Delegate
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}
extension GameViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animation = PopAnimator()
        animation.origin = self.view.subviews.last!.center
        animation.circleColor = UIColor.white
        
        if fromVC is GameViewController && toVC is DetailCardViewController {
            animation.transitionMode = .present
            return animation
        } else if toVC is GameViewController{
            animation.transitionMode = .dismiss
            return animation
        }
        
        return nil
    }
}
