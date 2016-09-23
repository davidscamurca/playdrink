//
//  Cards.swift
//  Play Drink
//
//  Created by David Camurça on 9/13/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import UIKit

class CardStore {
    
    static let singleton = CardStore()
    
    let dataCards:[(    Int,     // 0 > id
                        String,  // 1 > title
                        String,  // 2 > description
                        UIImage, // 3 > image
                        UIImage // 4 > bg_front
                        )] =
        [
            (   100,
                "Uma Dose",
                "Escolha alguém para tomar uma dose.",
                UIImage(named: "bgg01")!,
                UIImage(named: "bgf01")!
            ),
            
            (   200,
                "Duas Dose",
                "Escolha duas pessoas para tomar uma dose.",
                UIImage(named: "bgg02")!,
                UIImage(named: "bgf02")!
            ),
            
            (   300,
                "Espelho",
                "Escolha alguém para beber com você.",
                UIImage(named: "bgg03")!,
                UIImage(named: "bgf03")!
            ),
            
            (   400,
                "Fuga do Tema",
                "Escolha um tema e uma letra do alfabeto e diga uma palavra relacionada. Depois próximo jogador segue o padrão. O primeiro que errar ou não souber, bebe.",
                UIImage(named: "bgg04")!,
                UIImage(named: "bgf04")!
            ),
            
            (   500,
                "Memória",
                "Fale um palavra qualquer. O próximo tem que repetir a palavra anterior e adicionar outra começando com a útima letra da palavra anterior. Se errar ou não souber deve beber.",
                UIImage(named: "bgg05")!,
                UIImage(named: "bgf05")!
            ),
            
            (   600,
                "Continência",
                "Coloque a mão na testa fazendo continência e observe quais jogadores serão irão repetir o que você fez, quem imitar o ato por último bebe.",
                UIImage(named: "bgg06")!,
                UIImage(named: "bgf06")!
            ),
            
            (   700,
                "Pi",
                "Fale o número 1, o próximo jogador fala 2 e assim por diante. So que deve ser substituído por Pi todos os múltiplos de três.",
                UIImage(named: "bgg07")!,
                UIImage(named: "bgf07")!
            ),
            
            (   800,
                "Minha esquerda",
                "O jogador a sua esquerda bebe uma dose.",
                UIImage(named: "bgg08")!,
                UIImage(named: "bgf08")!
            ),
            
            (   900,
                "Só as mulheres",
                "Todas as mulheres da mesa bebem uma dose.",
                UIImage(named: "bgg09")!,
                UIImage(named: "bgf09")!
            ),
            
            (   1000,
                "Só os homens",
                "Todos os homens da mesa bebem uma dose.",
                UIImage(named: "bgg09")!,
                UIImage(named: "bgf09")!
            ),
            
            (   1100,
                "Somente Eu",
                "Somente você bebe uma dose.",
                UIImage(named: "bgg09")!,
                UIImage(named: "bgf09")!
            )
            
    
        ]

    
   // MARK : Return Cards Data
    
    func getCard()-> [Card] {
        
        var cards = [Card]()
        
        for dataCard in dataCards {
            
            let card = Card()
            
            card.id = dataCard.0
            card.title = dataCard.1
            card.descriptionn = dataCard.2
            card.image = dataCard.3
            card.bg_front = dataCard.4
        
            cards.append(card)
        }
        
        return cards
    
    }

}
