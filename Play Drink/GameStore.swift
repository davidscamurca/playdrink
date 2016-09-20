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
            "Sueca",
            UIImage(named: "ubuntuLogo")!
        ),
        (
            "Stop",
            UIImage(named: "fedoraLogo")!
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
