//
//  GameStore.swift
//  Play Drink
//
//  Created by Edson  Jr on 20/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import UIKit

class GameStore{
    
    static let singleton = GameStore()
    
    
    let dataGames:[(
            String, //title of game
            UIImage //logo of game
    
    )] = [
        (
            "Sueca Drink Game",
            UIImage(named: "iconSueca")!
        ),
        (
            "Tiger Arraived",
            UIImage(named: "iconTiger")!
        ),
        (
            "Nerd Drink",
            UIImage(named: "iconNerd")!
        ),
        (
            "Ferir Game",
            UIImage(named: "iconFerir")!
        ),
        (
            "Once Upon a Time",
            UIImage(named: "iconEraumavez")!
        
        ),
        (
            "More app's",
            UIImage(named: "mais01")!
        )
    
    ] //close dataGames
    
    
    func getGames() -> [Game] {
        
        var games = [Game]()
        
        for dataGame in dataGames {
            let game = Game()
            game.gameName = dataGame.0
            game.gameIcon = dataGame.1
            games.append(game)
            
        }
        
        return games
        
    }
}
