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
                        UIImage, // 4 > bg_front
                        UIImage  // 5 > bg_back
                        )] =
        [
            (   100,
                "Uma Dose",
                "Escolha alguém para tomar uma dose.",
                UIImage(named: "bgg_01")!,
                UIImage(named: "bgf_01")!,
                UIImage(named: "bgb_01")!
            ),
            
            (   200,
                "Duas Dose",
                "Escolha duas pessoas para tomar uma dose.",
                UIImage(named: "bgg_02")!,
                UIImage(named: "bgf_02")!,
                UIImage(named: "bgb_02")!
            ),
            
            (   300,
                "Espelho",
                "Escolha alguém para beber com você.",
                UIImage(named: "bgg_03")!,
                UIImage(named: "bgf_03")!,
                UIImage(named: "bgb_03")!
            ),
            
            (   400,
                "Fuga do Tema",
                "Escolha um tema e uma letra do alfabeto e diga uma palavra relacionada. Depois próximo jogador segue o padrão. O primeiro que errar ou não souber, bebe.",
                UIImage(named: "bgg_04")!,
                UIImage(named: "bgf_04")!,
                UIImage(named: "bgb_04")!
            ),
            
            (   500,
                "Memória",
                "Fale um palavra qualquer. O próximo tem que repetir a palavra anterior e adicionar outra começando com a útima letra da palavra anterior. Se errar ou não souber deve beber.",
                UIImage(named: "bgg_05")!,
                UIImage(named: "bgf_05")!,
                UIImage(named: "bgb_05")!
            ),
            
            (   600,
                "Continência",
                "Coloque a mão na testa fazendo continência e observe quais jogadores serão irão repetir o que você fez, quem imitar o ato por último bebe.",
                UIImage(named: "bgg_06")!,
                UIImage(named: "bgf_06")!,
                UIImage(named: "bgb_06")!
            ),
            
            (   700,
                "Pi",
                "Fale o número 1, o próximo jogador fala 2 e assim por diante. So que deve ser substituído por Pi todos os múltiplos de três.",
                UIImage(named: "bgg_07")!,
                UIImage(named: "bgf_07")!,
                UIImage(named: "bgb_07")!
            ),
            
            (   800,
                "Minha esquerda",
                "O jogador a sua esquerda bebe uma dose.",
                UIImage(named: "bgg_08")!,
                UIImage(named: "bgf_08")!,
                UIImage(named: "bgb_08")!
            ),
            
            (   900,
                "Só as mulheres",
                "Todas as mulheres da mesa bebem uma dose.",
                UIImage(named: "bgg_09")!,
                UIImage(named: "bgf_09")!,
                UIImage(named: "bgb_09")!
            ),
            
            (   1000,
                "Só os homens",
                "Todos os homens da mesa bebem uma dose.",
                UIImage(named: "bgg_09")!,
                UIImage(named: "bgf_09")!,
                UIImage(named: "bgb_09")!
            ),
            
            (   1100,
                "Somente Eu",
                "Somente você bebe uma dose.",
                UIImage(named: "bgg_09")!,
                UIImage(named: "bgf_09")!,
                UIImage(named: "bgb_09")!
            )
            
    
        ]

    
   // MARK : Return Cards Data
    
    func getCard()-> [Card] {
        
        var cards = [Card]()
        
        for dataCard in dataCards {
            
            let card = Card()
            
            card.id = dataCard.0
            card.tittle = dataCard.1
            card.description = dataCard.2
            card.image = dataCard.3
            card.bg_front = dataCard.4
            card.bg_back = dataCard.5
        
            cards.append(card)
        }
        
        return cards
    
    }

}
