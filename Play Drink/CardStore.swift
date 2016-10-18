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
                        UIImage, // 4 > mImage
                        UIImage // 4 > pImage
                        )] =
        [
            (   100,
                "Uma Dose",
                "Escolha alguém para tomar uma dose.",
                UIImage(named: "umaDose")!,
                UIImage(named: "mUmaDose")!,
                UIImage(named: "pUmaDose")!
            ),
            
            (   200,
                "Duas Dose",
                "Escolha duas pessoas para tomar uma dose.",
                UIImage(named: "duasDoses")!,
                UIImage(named: "mDuasDoses")!,
                UIImage(named: "pDuasDoses")!
            ),
            
            (   300,
                "Espelho",
                "Escolha alguém para beber com você.",
                UIImage(named: "espelho")!,
                UIImage(named: "mEspelho")!,
                UIImage(named: "pEspelho")!
            ),
            
            (   400,
                "Fuga do Tema",
                "Escolha um tema e uma letra do alfabeto e diga uma palavra relacionada. Depois próximo jogador segue o padrão. O primeiro que errar ou não souber, bebe.",
                UIImage(named: "fugaDoTema")!,
                UIImage(named: "mFuga")!,
                UIImage(named: "pFuga")!
            ),
            
            (   500,
                "Memória",
                "Fale um palavra qualquer. O próximo tem que repetir a palavra anterior e adicionar outra começando com a útima letra da palavra anterior. Se errar ou não souber deve beber.",
                UIImage(named: "queReiSouEu")!,
                UIImage(named: "mQueReiSouEu")!,
                UIImage(named: "pQueReiSouEu")!
            ),
            
            (   600,
                "Continência",
                "Coloque a mão na testa fazendo continência e observe quais jogadores serão irão repetir o que você fez, quem imitar o ato por último bebe.",
                UIImage(named: "oDaDireita")!,
                UIImage(named: "mDireita")!,
                UIImage(named: "pDireita")!
            ),
            
            (   700,
                "Pi",
                "Fale o número 1, o próximo jogador fala 2 e assim por diante. So que deve ser substituído por Pi todos os múltiplos de três.",
                UIImage(named: "pi")!,
                UIImage(named: "mPi")!,
                UIImage(named: "pPi")!
            ),
            
            (   800,
                "Minha esquerda",
                "O jogador a sua esquerda bebe uma dose.",
                UIImage(named: "oDaEsquerda")!,
                UIImage(named: "mEsquerda")!,
                UIImage(named: "pEsquerda")!
            ),
            
            (   900,
                "Só as mulheres",
                "Todas as mulheres da mesa bebem uma dose.",
                UIImage(named: "soMulheres")!,
                UIImage(named: "mSoMulheres")!,
                UIImage(named: "pSoMulheres")!
            ),
            
            (   1000,
                "Só os homens",
                "Todos os homens da mesa bebem uma dose.",
                UIImage(named: "soHomens")!,
                UIImage(named: "mSoHomens")!,
                UIImage(named: "pSoHomens")!
            ),
            
            (   1100,
                "Somente Eu",
                "Somente você bebe uma dose.",
                UIImage(named: "soEu")!,
                UIImage(named: "mSoEu")!,
                UIImage(named: "pSoEu")!
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
            card.mImage = dataCard.4
            card.pImage = dataCard.5
            
            cards.append(card)
        }
        
        return cards
    
    }

}
