//
//  PlayerStore.swift
//  Play Drink
//
//  Created by Edson  Jr on 20/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import UIKit

class PlayerStore {
    
    static let singleton = PlayerStore()
    
    
    
    let dataPlayers: [(
        String, //name of player
        String, //description of player
        UIImage //avatar of player
    )] = [
        (
            "Add",
            "Friends",
            UIImage(named:"mais01")!
        ),
        (
            "Anderson",
            "Suricate King",
            UIImage(named:"avatar05")!
        ),
        (
            "David",
            "The Support",
            UIImage(named:"avatar01")!
        ),
        (
            "Edson",
            "The Maniac",
            UIImage(named:"avatar03")!
        ),
        (
            "Vicente",
            "The Master",
            UIImage(named: "avatar02")!
        ),
        (
            "Arthur",
            "The Hyper",
            UIImage(named:"avatar01")!
        ),
        (
            "Nayara",
            "The Big",
            UIImage(named:"avatar03")!
        ),
        (
            "Antonio Jr",
            "The Maniac",
            UIImage(named:"avatar01")!
        ),
        (
            "Maria",
            "The Witch",
            UIImage(named:"avatar03")!
        ),
        (
            "Giovanne",
            "The Support",
            UIImage(named:"avatar01")!
        ),
        (
            "Max",
            "The Maniac",
            UIImage(named:"avatar02")!
        ),
        (
            "Guto",
            "The Maniac",
            UIImage(named:"avatar01")!
        ),
        (
            "Villar",
            "The Maniac",
            UIImage(named:"avatar03")!
        ),
        (
            "Thiago",
            "The Brave",
            UIImage(named: "avatar01")!
        )
    ]
    
    
    func getPlayers() -> [Player]{
        
        
        var players = [Player]()
        for p in dataPlayers{
            let player = Player()
            player.name = p.0
            player.description = p.1
            player.avatar = p.2
            
            players.append(player)
        }
        
        return players
    }
}
