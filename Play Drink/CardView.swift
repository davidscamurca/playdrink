//
//  CardView.swift
//  Play Drink
//
//  Created by Anderson Oliveira on 19/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import UIKit

class CardView: UIView {

    @IBOutlet var image: UIImageView!
    @IBOutlet var label: UILabel!
    
    func setup(data : Card, cornerRad : CGFloat, target : AnyObject) {
        self.label.text = data.title
        self.image.image = data.image
        self.image.layer.cornerRadius = cornerRad
        self.image.contentMode = UIViewContentMode.ScaleAspectFill
        self.image.clipsToBounds = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 3.0, height: 4.0)
        self.layer.drawsAsynchronously = true
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRad).CGPath
        UIView.animateWithDuration(0.01, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(1.35, 1.35)
            self.alpha = 0.7
        })
        self.layer.cornerRadius = cornerRad
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
