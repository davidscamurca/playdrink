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
        
        if let id = aDecoder.decodeObjectForKey("id") as? Int,
            let title = aDecoder.decodeObjectForKey("title") as? String,
            let descriptionn = aDecoder.decodeObjectForKey("descriptionn") as? String,
            let image = aDecoder.decodeObjectForKey("image") as? UIImage,
            let mImage = aDecoder.decodeObjectForKey("mImage") as? UIImage,
            let pImage = aDecoder.decodeObjectForKey("pImage") as? UIImage {
            
            self.id = id
            self.title = title
            self.descriptionn = descriptionn
            self.image = image
            self.mImage = mImage
            self.pImage = pImage
        }
        
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        if let id = self.id,
            let title = self.title,
            let descriptionn = self.descriptionn,
            let image = self.image,
            let mImage = self.mImage,
            let pImage = self.pImage
        {
            
            aCoder.encodeObject(id, forKey: "id")
            aCoder.encodeObject(title, forKey: "title")
            aCoder.encodeObject(descriptionn, forKey: "descriptionn")
            aCoder.encodeObject(image, forKey: "image")
            aCoder.encodeObject(mImage, forKey: "mImage")
            aCoder.encodeObject(pImage, forKey: "pImage")
        }
    }
    
}
