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
                UIImage //avatar of player
    )] = [
        (
            "Anderson",
            UIImage(named:"ubuntuLogo")!
        ),
        (
            "Vicente",
            UIImage(named: "ubuntuLogo")!
        
        )
    
    ]
    
    
    func getPlayers() -> [Player]{
        
        
        var players = [Player]()
        for p in dataPlayers{
            let player = Player()
            player.name = p.0
            player.avatar = p.1
            
            players.append(player)
        }
        
        return players
    }
}
