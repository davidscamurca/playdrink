//
//  ArrayExtensions.swift
//  Play Drink
//
//  Created by Edson  Jr on 14/09/16.
//  Copyright © 2016 David Camurça. All rights reserved.
//

import Foundation


extension Array {
    ///embaralhamento simples de um array. Baseado em troca de posicoes. Retorna um novo array com elementos embaralhados.
    func suffle() -> [Element] {
        if count < 2 { return self }
        var list = self
        for i in 0..<(list.count-1){
            let random = Int(arc4random_uniform(UInt32(list.count - i)))+i
            if random != i {
                swap(&list[i],&list[random])
            }
            
        }
        return list
    }
}
