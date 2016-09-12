//
//  Card.swift
//  Play Drink
//
//  Created by Edson  Jr on 12/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import Foundation
import UIKit

class Card {
    
    var ID: Int?
    var tittle: String?
    var description: String?
    var image:UIImage?
    var background_front: UIImage?
    var background_back: UIImage?
    
    

    init(id: Int, tittle: String, description: String,image: String, background_front: String,
         background_back: String){
        self.ID = id
        self.tittle = tittle
        self.description = description
        self.image = UIImage(named: image)
        self.background_front = UIImage(named: background_front)
        self.background_back = UIImage(named:  background_back)
        
    }
    
    
}
