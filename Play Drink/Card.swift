//
//  Card.swift
//  Play Drink
//
//  Created by Edson  Jr on 12/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//


import UIKit

class Card: NSObject, NSCoding {
    
    
    var id: Int!
    var title: String!
    var descriptionn: String!
    var image: UIImage!
    var mImage: UIImage!
    var pImage: UIImage!
    
    override init() {}
    
    required init(coder aDecoder: NSCoder){
        
        if let id = aDecoder.decodeObject(forKey: "id") as? Int,
            let title = aDecoder.decodeObject(forKey: "title") as? String,
            let descriptionn = aDecoder.decodeObject(forKey: "descriptionn") as? String,
            let image = aDecoder.decodeObject(forKey: "image") as? UIImage,
            let mImage = aDecoder.decodeObject(forKey: "mImage") as? UIImage,
            let pImage = aDecoder.decodeObject(forKey: "pImage") as? UIImage {
            
            self.id = id
            self.title = title
            self.descriptionn = descriptionn
            self.image = image
            self.mImage = mImage
            self.pImage = pImage
        }
        
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        if let id = self.id,
            let title = self.title,
            let descriptionn = self.descriptionn,
            let image = self.image,
            let mImage = self.mImage,
            let pImage = self.pImage
        {
            
            aCoder.encode(id, forKey: "id")
            aCoder.encode(title, forKey: "title")
            aCoder.encode(descriptionn, forKey: "descriptionn")
            aCoder.encode(image, forKey: "image")
            aCoder.encode(mImage, forKey: "mImage")
            aCoder.encode(pImage, forKey: "pImage")
        }
    }
    
}
